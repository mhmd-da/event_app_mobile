import 'package:sqlite3/sqlite3.dart';
import 'dart:convert';

class LocalCacheService {
  final Database db;
  LocalCacheService(this.db);

  // Sanitize table name: remove query params and invalid chars
  String _sanitizeTableName(String table) {
    // Remove query params
    final noQuery = table.split('?').first;
    // Replace non-alphanumeric/underscore chars with _
    return noQuery.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
  }

  void ensureTable(String table) {
    final safeTable = _sanitizeTableName(table);
    db.execute('''CREATE TABLE IF NOT EXISTS $safeTable (
      id TEXT PRIMARY KEY,
      data TEXT NOT NULL
    )''');
  }

  void put(String table, String id, Map<String, dynamic> data) {
    final safeTable = _sanitizeTableName(table);
    ensureTable(table);
    db.execute('REPLACE INTO $safeTable (id, data) VALUES (?, ?)', [id, jsonEncode(data)]);
  }

  Map<String, dynamic>? get(String table, String id) {
    final safeTable = _sanitizeTableName(table);
    ensureTable(table);
    final result = db.select('SELECT data FROM $safeTable WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return jsonDecode(result.first['data'] as String);
  }

  List<Map<String, dynamic>> getAll(String table) {
    final safeTable = _sanitizeTableName(table);
    ensureTable(table);
    final result = db.select('SELECT data FROM $safeTable');
    return result.map((row) => jsonDecode(row['data'] as String) as Map<String, dynamic>).toList();
  }
}
