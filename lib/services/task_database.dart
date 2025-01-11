import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasks/models/task_model.dart';

class TaskDatabase {
  static Database? _database;

  // Initialize the database
  static Future<Database> _initDatabase() async {
    if (_database != null) {
      return _database!;
    }
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasks.db');
    _database =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      // Create table with createdAt column
      await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,  
        title TEXT,
        description TEXT,
        createdAt TEXT, 
        isDone INTEGER  
      )
      ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      // If the database is upgraded, add the new column for createdAt
      if (oldVersion < 2) {
        await db.execute('ALTER TABLE tasks ADD COLUMN createdAt TEXT');
      }
    });
    return _database!;
  }

  // Load tasks from the database
  static Future<List<TaskModel>> loadTasks() async {
    final db = await _initDatabase();
    final List<Map<String, dynamic>> taskListMap = await db.query('tasks');
    return taskListMap.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
  }

  // Save tasks to the database
  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final db = await _initDatabase();
    await db.delete('tasks');

    for (var task in tasks) {
      await db.insert('tasks', task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Add a task
  static Future<void> addTask(TaskModel task) async {
    final db = await _initDatabase();
    await db.insert('tasks', task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Remove a task
  static Future<void> removeTask(TaskModel task) async {
    final db = await _initDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
  }

  // Update a task's completion status
  static Future<void> updateTask(TaskModel task) async {
    final db = await _initDatabase();
    await db
        .update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }
}
