import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper instance = LocalDatabaseHelper._init();
  static Database? _database;

  LocalDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ehs_track_pro_offline.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // 1. Incidents Table
    await db.execute('''
      CREATE TABLE incidents (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        location TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        severity_level INTEGER NOT NULL,
        annotated_photo_path TEXT,
        created_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 2. CAPA Actions Table
    await db.execute('''
      CREATE TABLE capas (
        id TEXT PRIMARY KEY,
        incident_id TEXT,
        action_title TEXT NOT NULL,
        assignee TEXT NOT NULL,
        deadline TEXT NOT NULL,
        status TEXT NOT NULL,
        priority TEXT NOT NULL,
        evidence_photo_path TEXT,
        created_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 3. Work Permits (PTW) & Forms Table
    await db.execute('''
      CREATE TABLE work_permits (
        id TEXT PRIMARY KEY,
        permit_type TEXT NOT NULL,
        site_location TEXT NOT NULL,
        valid_until TEXT NOT NULL,
        officer_signature_data TEXT,
        status TEXT NOT NULL,
        created_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 4. Offline Delta Sync Queue (Outbox Pattern)
    await db.execute('''
      CREATE TABLE sync_outbox (
        mutation_id TEXT PRIMARY KEY,
        entity_name TEXT NOT NULL,
        entity_id TEXT NOT NULL,
        operation TEXT NOT NULL,
        payload_json TEXT NOT NULL,
        created_at TEXT NOT NULL,
        retry_count INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // --- CRUD & Sync helpers ---
  Future<int> insertIncident(Map<String, dynamic> row) async {
    final db = await instance.database;
    final res = await db.insert('incidents', row, conflictAlgorithm: ConflictAlgorithm.replace);
    
    // Append to sync outbox
    await db.insert('sync_outbox', {
      'mutation_id': DateTime.now().millisecondsSinceEpoch.toString(),
      'entity_name': 'incidents',
      'entity_id': row['id'],
      'operation': 'UPSERT',
      'payload_json': row.toString(),
      'created_at': DateTime.now().toIso8601String(),
      'retry_count': 0
    });
    return res;
  }

  Future<List<Map<String, dynamic>>> getPendingSyncMutations() async {
    final db = await instance.database;
    return await db.query('sync_outbox', orderBy: 'created_at ASC');
  }

  Future<void> removeSyncMutation(String mutationId) async {
    final db = await instance.database;
    await db.delete('sync_outbox', where: 'mutation_id = ?', whereArgs: [mutationId]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
