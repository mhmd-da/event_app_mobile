import 'dart:io';
import 'package:sqlite3/sqlite3.dart' as sq;
import 'package:path_provider/path_provider.dart';

class ChatSqliteRepository {
  sq.Database? _db;

  Future<void> open() async {
    if (_db != null) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/chat.sqlite');
    _db = sq.sqlite3.open(file.path);
    _createSchema();
  }

  void _createSchema() {
    _db!.execute('''
      CREATE TABLE IF NOT EXISTS chat_messages (
        local_id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id INTEGER NOT NULL,
        server_message_id INTEGER,
        client_message_id TEXT NOT NULL,
        sender_user_id INTEGER NOT NULL,
        sender_name TEXT,
        text TEXT NOT NULL,
        created_at TEXT NOT NULL,
        status TEXT NOT NULL
      );
    ''');
    _ensureSenderNameColumn();
  }

  void _ensureSenderNameColumn() {
    try {
      final rs = _db!.select("PRAGMA table_info(chat_messages)");
      final has = rs.any((row) => (row['name'] as String) == 'sender_name');
      if (!has) {
        _db!.execute('ALTER TABLE chat_messages ADD COLUMN sender_name TEXT');
      }
    } catch (_) {}
  }

  Future<void> insertIncomingMessage({
    required int groupId,
    required int serverMessageId,
    required int senderUserId,
    required String text,
    required DateTime createdAt,
    String? clientMessageId,
    String? senderName,
  }) async {
    _db!.execute(
      'INSERT INTO chat_messages (group_id, server_message_id, client_message_id, sender_user_id, sender_name, text, created_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [groupId, serverMessageId, clientMessageId ?? '', senderUserId, senderName ?? '', text, createdAt.toIso8601String(), 'sent'],
    );
  }

  Future<void> insertOutgoingMessagePending({
    required int groupId,
    required String clientMessageId,
    required int senderUserId,
    required String text,
    required DateTime createdAt,
  }) async {
    _db!.execute(
      'INSERT INTO chat_messages (group_id, server_message_id, client_message_id, sender_user_id, sender_name, text, created_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [groupId, null, clientMessageId, senderUserId, '', text, createdAt.toIso8601String(), 'pending'],
    );
  }

  Future<void> markMessageSent({
    required String clientMessageId,
    int? serverMessageId,
  }) async {
    _db!.execute(
      'UPDATE chat_messages SET status = ?, server_message_id = COALESCE(?, server_message_id) WHERE client_message_id = ?',
      ['sent', serverMessageId, clientMessageId],
    );
  }

  Future<void> markMessageFailed({
    required String clientMessageId,
  }) async {
    _db!.execute(
      'UPDATE chat_messages SET status = ? WHERE client_message_id = ?',
      ['failed', clientMessageId],
    );
  }

  bool hasMessageByClientId(String clientMessageId) {
    final rs = _db!.select(
      'SELECT 1 FROM chat_messages WHERE client_message_id = ? LIMIT 1',
      [clientMessageId],
    );
    return rs.isNotEmpty;
  }

  List<ChatMessage> fetchMessages(int groupId) {
    final rs = _db!.select(
      'SELECT local_id, group_id, server_message_id, client_message_id, sender_user_id, sender_name, text, created_at, status FROM chat_messages WHERE group_id = ? ORDER BY local_id ASC',
      [groupId],
    );
    return rs.map((row) {
      return ChatMessage(
        localId: row['local_id'] as int,
        groupId: row['group_id'] as int,
        serverMessageId: (row['server_message_id'] as int?) ?? 0,
        clientMessageId: row['client_message_id'] as String,
        senderUserId: row['sender_user_id'] as int,
        senderName: (row['sender_name'] as String?) ?? '',
        text: row['text'] as String,
        createdAt: DateTime.parse(row['created_at'] as String),
        status: row['status'] as String,
      );
    }).toList();
  }
}

class ChatMessage {
  final int localId;
  final int groupId;
  final int serverMessageId;
  final String clientMessageId;
  final int senderUserId;
  final String senderName;
  final String text;
  final DateTime createdAt;
  final String status;
  ChatMessage({
    required this.localId,
    required this.groupId,
    required this.serverMessageId,
    required this.clientMessageId,
    required this.senderUserId,
    required this.senderName,
    required this.text,
    required this.createdAt,
    required this.status,
  });
}
