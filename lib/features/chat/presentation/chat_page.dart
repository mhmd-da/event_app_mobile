import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/features/chat/presentation/chat_providers.dart';
import 'package:event_app/features/chat/data/chat_sqlite_repository.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';

class ChatPage extends ConsumerStatefulWidget {
  final int sessionId;
  const ChatPage({super.key, required this.sessionId});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _input = TextEditingController();
  final List<ChatMessage> _messages = [];
  int? _groupId; // actual server groupId for this session
  final ScrollController _scrollController = ScrollController();
  int? _currentUserId;

  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    final svc = ref.read(chatRealtimeServiceProvider);
    final repo = ref.read(chatSqliteRepositoryProvider);
    // Load current user id
    ref.read(secureStorageProvider).getUserId().then((id) {
      setState(() {
        _currentUserId = id;
      });
    });
    repo.open().then((_) {
      final initial = _composeMessages(repo);
      setState(() {
        _messages
          ..clear()
          ..addAll(initial);
      });
      _scrollToBottom();
    });
    svc.onMessageReceived((args) async {
      try {
        if (args == null || args.isEmpty) return;
        final first = args[0];
        if (first is! Map) return;
        final map = Map<String, dynamic>.from(first);
        final gid = (map['groupId'] as int?) ?? widget.sessionId;
        final serverMessageId = (map['id'] as int?) ?? 0;
        final senderId = (map['senderUserId'] as int?) ?? 0;
        final senderName =
            (map['senderDisplayName'] as String?) ??
            (map['senderName'] as String?) ??
            '';
        final text = (map['text'] as String?) ?? '';
        final createdAtStr = (map['createdAt'] as String?) ?? '';
        final createdAt = _parseServerUtc(createdAtStr);
        final cId = (map['clientMessageId'] as String?) ?? '';

        if (cId.isNotEmpty && repo.hasMessageByClientId(cId)) {
          await repo.markMessageSent(
            clientMessageId: cId,
            serverMessageId: serverMessageId,
          );
        } else {
          await repo.insertIncomingMessage(
            groupId: gid,
            serverMessageId: serverMessageId,
            senderUserId: senderId,
            senderName: senderName,
            text: text,
            createdAt: createdAt,
            clientMessageId: cId,
          );
        }
        _groupId ??= gid;
        final updated = _composeMessages(repo);
        setState(() {
          _messages
            ..clear()
            ..addAll(updated);
        });
        _scrollToBottom();
      } catch (_) {}
    });
    _connectAndJoin();
  }

  Future<void> _connectAndJoin() async {
    final svc = ref.read(chatRealtimeServiceProvider);
    await svc.start();
    await svc.joinSession(widget.sessionId);
  }

  @override
  void dispose() {
    _input.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(l10n.sessionChatTitle)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isMe =
                    _currentUserId != null && m.senderUserId == _currentUserId;
                final bubbleColor = isMe
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest;
                final textColor = isMe
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface;
                final align = isMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
                final radius = BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: Radius.circular(isMe ? 12 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 12),
                );
                return Align(
                  alignment: align,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: radius,
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (!isMe && (m.senderName.isNotEmpty))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                m.senderName,
                                style: TextStyle(
                                  color: textColor.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (isMe)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                l10n.youLabel,
                                style: TextStyle(
                                  color: textColor.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          Text(
                            m.text,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              AppTimeFormatting.formatTimeHm(
                                context,
                                m.createdAt,
                              ),
                              style: TextStyle(
                                color: textColor.withValues(alpha: 0.8),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) async => _handleSend(),
                      decoration: InputDecoration(
                        hintText: l10n.typeMessageHint,
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async => _handleSend(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSend() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    final svc = ref.read(chatRealtimeServiceProvider);
    final repo = ref.read(chatSqliteRepositoryProvider);
    final clientId = _uuid.v4();
    try {
      _input.clear();
      await repo.insertOutgoingMessagePending(
        groupId: _groupId ?? widget.sessionId,
        clientMessageId: clientId,
        senderUserId: _currentUserId ?? 0,
        text: text,
        createdAt: DateTime.now().toUtc(),
      );
      final result = await svc.sendMessage(
        sessionId: widget.sessionId,
        clientMessageId: clientId,
        text: text,
      );
      try {
        final v = result['groupId'];
        if (v is int) {
          _groupId = v;
        }
      } catch (_) {}
      int? serverId;
      try {
        final v = result['serverMessageId'];
        if (v is int) serverId = v;
      } catch (_) {}
      await repo.markMessageSent(
        clientMessageId: clientId,
        serverMessageId: serverId,
      );
      final updated = _composeMessages(repo);
      setState(() {
        _messages
          ..clear()
          ..addAll(updated);
      });
      _scrollToBottom();
    } catch (_) {
      await repo.markMessageFailed(clientMessageId: clientId);
      final updated = _composeMessages(repo);
      setState(() {
        _messages
          ..clear()
          ..addAll(updated);
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  // Parse server timestamps that may be emitted as UTC without timezone info.
  // Ensures we treat naive strings as UTC, then convert to local only at render.
  DateTime _parseServerUtc(String s) {
    if (s.isEmpty) return DateTime.now().toUtc();
    final hasZone = RegExp(r'(Z|[+-]\d{2}:?\d{2})$').hasMatch(s);
    final normalized = hasZone ? s : '${s}Z';
    try {
      return DateTime.parse(normalized).toUtc();
    } catch (_) {
      try {
        return DateTime.parse(s).toUtc();
      } catch (_) {
        return DateTime.now().toUtc();
      }
    }
  }

  List<ChatMessage> _composeMessages(ChatSqliteRepository repo) {
    final a = repo.fetchMessages(widget.sessionId);
    if (_groupId != null && _groupId != widget.sessionId) {
      final b = repo.fetchMessages(_groupId!);
      a.addAll(b);
      a.sort((l, r) => l.localId.compareTo(r.localId));
    }
    return a;
  }
}
