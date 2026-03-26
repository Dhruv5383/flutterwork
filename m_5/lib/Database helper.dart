// lib/database/database_helper.dart
// Manages all SQLite operations for TaskMate using sqflite

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Task model.dart';
//import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _dbName = 'taskmate.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'tasks';

  /// Returns the singleton database instance, initializing if needed
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the SQLite database and create tables
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create the tasks table schema
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        title     TEXT    NOT NULL,
        description TEXT  NOT NULL,
        due_date  TEXT    NOT NULL,
        status    TEXT    NOT NULL DEFAULT 'pending',
        created_at TEXT   NOT NULL
      )
    ''');
  }

  /// Handle future database schema migrations
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migration logic goes here
  }

  // ─────────────────────────────────────────────
  // CREATE
  // ─────────────────────────────────────────────

  /// Insert a new task and return its generated id
  Future<int> insertTask(Task task) async {
    try {
      final db = await database;
      final id = await db.insert(
        _tableName,
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      throw Exception('Failed to insert task: $e');
    }
  }

  // ─────────────────────────────────────────────
  // READ
  // ─────────────────────────────────────────────

  /// Fetch all tasks ordered by due date ascending
  Future<List<Task>> getAllTasks() async {
    try {
      final db = await database;
      final maps = await db.query(
        _tableName,
        orderBy: 'due_date ASC',
      );
      return maps.map((map) => Task.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  /// Fetch tasks filtered by status
  Future<List<Task>> getTasksByStatus(TaskStatus status) async {
    try {
      final db = await database;
      final maps = await db.query(
        _tableName,
        where: 'status = ?',
        whereArgs: [status.value],
        orderBy: 'due_date ASC',
      );
      return maps.map((map) => Task.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks by status: $e');
    }
  }

  /// Fetch a single task by its id
  Future<Task?> getTaskById(int id) async {
    try {
      final db = await database;
      final maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) return null;
      return Task.fromMap(maps.first);
    } catch (e) {
      throw Exception('Failed to fetch task by id: $e');
    }
  }

  /// Search tasks by title or description keyword
  Future<List<Task>> searchTasks(String query) async {
    try {
      final db = await database;
      final maps = await db.query(
        _tableName,
        where: 'title LIKE ? OR description LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'due_date ASC',
      );
      return maps.map((map) => Task.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to search tasks: $e');
    }
  }

  // ─────────────────────────────────────────────
  // UPDATE
  // ─────────────────────────────────────────────

  /// Update an existing task; returns number of rows affected
  Future<int> updateTask(Task task) async {
    try {
      final db = await database;
      return await db.update(
        _tableName,
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  /// Quickly toggle a task's status
  Future<int> updateTaskStatus(int id, TaskStatus status) async {
    try {
      final db = await database;
      return await db.update(
        _tableName,
        {'status': status.value},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to update task status: $e');
    }
  }

  // ─────────────────────────────────────────────
  // DELETE
  // ─────────────────────────────────────────────

  /// Delete a task by id; returns number of rows deleted
  Future<int> deleteTask(int id) async {
    try {
      final db = await database;
      return await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  /// Delete all completed tasks (bulk cleanup)
  Future<int> deleteCompletedTasks() async {
    try {
      final db = await database;
      return await db.delete(
        _tableName,
        where: 'status = ?',
        whereArgs: [TaskStatus.completed.value],
      );
    } catch (e) {
      throw Exception('Failed to delete completed tasks: $e');
    }
  }

  // ─────────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────────

  /// Return task counts grouped by status
  Future<Map<String, int>> getTaskStats() async {
    try {
      final db = await database;
      final result = await db.rawQuery('''
        SELECT status, COUNT(*) as count
        FROM $_tableName
        GROUP BY status
      ''');
      final stats = <String, int>{
        'pending': 0,
        'in_progress': 0,
        'completed': 0,
      };
      for (final row in result) {
        stats[row['status'] as String] = row['count'] as int;
      }
      return stats;
    } catch (e) {
      throw Exception('Failed to get task stats: $e');
    }
  }

  /// Close the database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}