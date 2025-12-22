import 'dart:async';
import 'dart:convert';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:dio/dio.dart';
import 'package:event_app/core/utilities/logger.dart';

class ChatRealtimeService {
  final String hubUrl;
  final Future<String> Function() getAccessToken;

  HubConnection? _conn;
  final _connected = StreamController<bool>.broadcast();
  final List<void Function(List<Object?>? args)> _messageHandlers = [];
  final Set<int> _joinedSessions = <int>{};

  Stream<bool> get connected$ => _connected.stream;
  bool get isConnected => _conn?.state == HubConnectionState.Connected;

  ChatRealtimeService({required this.hubUrl, required this.getAccessToken});

  Future<void> start() async {
    if (_conn != null &&
        (_conn!.state == HubConnectionState.Connected ||
         _conn!.state == HubConnectionState.Connecting)) {
      logInfo('SignalR already connected/connecting: state=${_conn!.state}');
      return;
    }

    logInfo('SignalR starting connection to $hubUrl');
    // Prefer WebSockets transport; retry with LongPolling if WebSockets fail.
    final token = await getAccessToken();
    if (token.isEmpty) {
      logError('SignalR start failed: empty auth token', null);
      throw Exception('Unauthorized: missing auth token');
    }

    _logTokenClaims(token);
    final urlWithToken = '$hubUrl?access_token=${Uri.encodeComponent(token)}';
    final wsOptions = HttpConnectionOptions(
      transport: HttpTransportType.WebSockets,
      accessTokenFactory: () async => token,
    );
    var conn = HubConnectionBuilder()
        .withUrl(urlWithToken, options: wsOptions)
        .withAutomaticReconnect()
        .build();

    _conn = conn;
    _attachCoreCallbacks(conn);
    _attachHandlers(conn);

    // Configure heartbeat/timeout for resilience
    conn.serverTimeoutInMilliseconds = 60000; // 60s
    conn.keepAliveIntervalInMilliseconds = 15000; // 15s

    try {
      await conn.start();
      logInfo('SignalR started successfully via WebSockets');
      _connected.add(true);
    } catch (e, st) {
      logError('SignalR start failed (WebSockets)', e, st);
      await _debugNegotiate(token);
      // Fallback to LongPolling
      logInfo('Retrying SignalR start with LongPolling');
      final lpOptions = HttpConnectionOptions(
        transport: HttpTransportType.LongPolling,
        accessTokenFactory: () async => token,
      );
      conn = HubConnectionBuilder()
          .withUrl(urlWithToken, options: lpOptions)
          .withAutomaticReconnect()
          .build();
      _conn = conn;
      _attachCoreCallbacks(conn);
      _attachHandlers(conn);
      conn.serverTimeoutInMilliseconds = 60000;
      conn.keepAliveIntervalInMilliseconds = 15000;
      try {
        await conn.start();
        logInfo('SignalR started successfully via LongPolling');
        _connected.add(true);
      } catch (e2, st2) {
        logError('SignalR start failed (LongPolling)', e2, st2);
        rethrow;
      }
    }
  }

  Future<void> _debugNegotiate(String token) async {
    try {
      final dio = Dio();
      // Attempt with Authorization header
      final headerUrl = Uri.parse('$hubUrl/negotiate?negotiateVersion=1');
      final resHeader = await dio.post(
        headerUrl.toString(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true, // don't throw; we want to log
        ),
      );
      logInfo('Negotiate (header) status=${resHeader.statusCode}');

      // Attempt with access_token in query
      final queryUrl = Uri.parse('$hubUrl/negotiate?negotiateVersion=1&access_token=${Uri.encodeComponent(token)}');
      final resQuery = await dio.post(
        queryUrl.toString(),
        options: Options(validateStatus: (_) => true),
      );
      logInfo('Negotiate (query) status=${resQuery.statusCode}');
    } catch (e, st) {
      logError('Negotiate check failed', e, st);
    }
  }

  void onMessageReceived(void Function(List<Object?>? args) handler) {
    _messageHandlers.add(handler);
    if (_conn != null) {
      _conn!.on("MessageReceived", (args) {
        logInfo('SignalR MessageReceived: args=$args');
        handler(args);
      });
    }
  }

  Future<void> joinSession(int sessionId) async {
    logInfo('Invoking JoinSession for sessionId=$sessionId');
    try {
      await _conn!.invoke("JoinSession", args: [sessionId]);
      logInfo('JoinSession succeeded for sessionId=$sessionId');
      _joinedSessions.add(sessionId);
    } catch (e, st) {
      logError('JoinSession failed for sessionId=$sessionId', e, st);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendMessage({
    required int sessionId,
    required String clientMessageId,
    required String text,
  }) async {
    logInfo('Invoking SendMessage sessionId=$sessionId clientId=$clientMessageId');
    try {
      final result = await _conn!.invoke("SendMessage", args: [
        sessionId,
        clientMessageId,
        text,
      ]);
      // If the hub returns a payload, parse it; otherwise, return empty map
      Map<String, dynamic> map = {};
      if (result is Map) {
        map = Map<String, dynamic>.from(result);
      }
      logInfo('SendMessage succeeded: result=${map.isEmpty ? '<<no payload>>' : map}');
      return map;
    } catch (e, st) {
      logError('SendMessage invoke failed, trying send() fallback', e, st);
      // Try alternative argument shapes commonly used by hubs
      // 1) Swapped order: [sessionId, text, clientMessageId]
      try {
        final altResult = await _conn!.invoke("SendMessage", args: [
          sessionId,
          text,
          clientMessageId,
        ]);
        Map<String, dynamic> altMap = {};
        if (altResult is Map) {
          altMap = Map<String, dynamic>.from(altResult);
        }
        logInfo('SendMessage alt invoke (swapped args) succeeded: result=${altMap.isEmpty ? '<<no payload>>' : altMap}');
        return altMap;
      } catch (eAlt, stAlt) {
        logError('SendMessage alt invoke (swapped args) failed', eAlt, stAlt);
      }

      // 2) DTO payload: [{ sessionId, clientMessageId, text }]
      try {
        final dtoResult = await _conn!.invoke("SendMessage", args: [
          {
            'sessionId': sessionId,
            'clientMessageId': clientMessageId,
            'text': text,
          }
        ]);
        Map<String, dynamic> dtoMap = {};
        if (dtoResult is Map) {
          dtoMap = Map<String, dynamic>.from(dtoResult);
        }
        logInfo('SendMessage DTO invoke succeeded: result=${dtoMap.isEmpty ? '<<no payload>>' : dtoMap}');
        return dtoMap;
      } catch (eDto, stDto) {
        logError('SendMessage DTO invoke failed', eDto, stDto);
      }

      try {
        await _conn!.send("SendMessage", args: [
          sessionId,
          clientMessageId,
          text,
        ]);
        logInfo('SendMessage send() fallback succeeded');
        return {};
      } catch (e2, st2) {
        logError('SendMessage send() fallback failed', e2, st2);
        // Try swapped order with send
        try {
          await _conn!.send("SendMessage", args: [
            sessionId,
            text,
            clientMessageId,
          ]);
          logInfo('SendMessage send() swapped args succeeded');
          return {};
        } catch (e3, st3) {
          logError('SendMessage send() swapped args failed', e3, st3);
        }
        // Try DTO with send
        try {
          await _conn!.send("SendMessage", args: [
            {
              'sessionId': sessionId,
              'clientMessageId': clientMessageId,
              'text': text,
            }
          ]);
          logInfo('SendMessage send() DTO succeeded');
          return {};
        } catch (e4, st4) {
          logError('SendMessage send() DTO failed', e4, st4);
        }
        rethrow;
      }
    }
  }

  Future<void> stop() async {
    logInfo('SignalR stopping connection');
    await _conn?.stop();
    _conn = null;
    _connected.add(false);
  }

  void _attachCoreCallbacks(HubConnection conn) {
    conn.onclose(({error}) {
      logError('SignalR connection closed', error);
      _connected.add(false);
    });
    conn.onreconnecting(({error}) {
      logError('SignalR reconnecting', error);
      _connected.add(false);
    });
    conn.onreconnected(({connectionId}) async {
      logInfo('SignalR reconnected: connectionId=$connectionId');
      _connected.add(true);
      // Re-join previously joined sessions on reconnect
      for (final sid in _joinedSessions) {
        try {
          await conn.invoke("JoinSession", args: [sid]);
          logInfo('Re-joined session after reconnect: $sid');
        } catch (e, st) {
          logError('Failed to re-join session $sid after reconnect', e, st);
        }
      }
    });
  }

  void _attachHandlers(HubConnection conn) {
    // Attach MessageReceived to current connection for all registered handlers
    if (_messageHandlers.isEmpty) return;
    conn.off("MessageReceived");
    for (final h in _messageHandlers) {
      conn.on("MessageReceived", (args) {
        logInfo('SignalR MessageReceived: args=$args');
        h(args);
      });
    }
  }

  void _logTokenClaims(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return;
      String normalize(String str) {
        return str.padRight(str.length + (4 - str.length % 4) % 4, '=');
      }
      final payload = utf8.decode(base64Url.decode(normalize(parts[1])));
      final map = json.decode(payload) as Map<String, dynamic>;
      final sub = map['sub'];
      final nameId = map['nameid'] ?? map['nameId'] ?? map['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
      final exp = map['exp'];
      logInfo('JWT claims: sub=$sub nameid=$nameId exp=$exp');
    } catch (e, st) {
      logError('Failed to decode JWT claims', e, st);
    }
  }
}
