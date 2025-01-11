import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static Database? _database;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Initialize the SQLite database
  static Future<Database> _initDatabase() async {
    if (_database != null) {
      return _database!;
    }
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasks.db');
    _database =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY,  
          title TEXT,
          description TEXT,
          createdAt TEXT, 
          isComplete INTEGER  
        )
      ''');
    });
    return _database!;
  }

  // Sync tasks with Firestore and SQLite
  static Future<void> syncTasksWithFirestore(List<TaskModel> tasks) async {
    // Sync tasks with Firestore
    for (var task in tasks) {
      await firestore
          .collection('tasks')
          .doc(task.id.toString())
          .set(task.toJson());
    }
  }

  // Load tasks from Firestore
  static Future<List<TaskModel>> loadTasksFromFirestore() async {
    final snapshot = await firestore.collection('tasks').get();
    return snapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList();
  }

  // Save tasks to the SQLite database
  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final db = await _initDatabase();
    await db.delete('tasks');
    for (var task in tasks) {
      await db.insert('tasks', task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Add a task to SQLite and Firestore
  static Future<void> addTask(TaskModel task) async {
    final db = await _initDatabase();
    await db.insert('tasks', task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await firestore
        .collection('tasks')
        .doc(task.id.toString())
        .set(task.toJson());
  }

  // Remove a task from SQLite and Firestore
  static Future<void> removeTask(TaskModel task) async {
    final db = await _initDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    await firestore.collection('tasks').doc(task.id.toString()).delete();
  }

  // Update a task in SQLite and Firestore
  static Future<void> updateTask(TaskModel task) async {
    final db = await _initDatabase();
    await db
        .update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
    await firestore
        .collection('tasks')
        .doc(task.id.toString())
        .update(task.toJson());
  }

  // Load tasks from the SQLite database
  static Future<List<TaskModel>> loadTasksFromSQLite() async {
    final db = await _initDatabase();
    final List<Map<String, dynamic>> taskListMap = await db.query('tasks');
    return taskListMap.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
  }
}
