import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/services/task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  bool isLoading = false;
  final List<TaskModel> _allTasks = [];

  // Load tasks from both Firestore and SQLite
  Future<void> loadTasks() async {
    // First, load tasks from SQLite
    List<TaskModel> localTasks = await TaskDatabase.loadTasksFromSQLite();

    // Then, load tasks from Firestore
    List<TaskModel> firestoreTasks =
        await TaskDatabase.loadTasksFromFirestore();

    // Merge tasks and avoid duplicates
    _allTasks.clear();
    _allTasks.addAll(firestoreTasks);
    _allTasks.addAll(localTasks);

    tasks = List.from(_allTasks); // Update the task list to include both
    notifyListeners();
  }

  // Save tasks to both SQLite and Firestore
  Future<void> saveTasks() async {
    await TaskDatabase.saveTasks(tasks);
    await TaskDatabase.syncTasksWithFirestore(tasks);
  }

  // Add a task
  Future<void> addTask(TaskModel task) async {
    await TaskDatabase.addTask(task);
    tasks.add(task);
    _allTasks.add(task);
    await saveTasks();
    notifyListeners();
  }

  // Remove a task
  Future<void> removeTask(TaskModel task) async {
    await TaskDatabase.removeTask(task);
    tasks.remove(task);
    _allTasks.remove(task);
    await saveTasks();
    notifyListeners();
  }

  // Update a task's completion status
  Future<void> updateTask(bool isComplete, TaskModel task) async {
    task.isComplete = isComplete;
    await TaskDatabase.updateTask(task);
    await saveTasks();
    notifyListeners();
  }

  // Search function that filters tasks based on query
  void searchTask(String query) {
    if (query.isEmpty) {
      tasks = List.from(_allTasks);
    } else {
      tasks = _allTasks.where((task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  List<TaskModel> get getTasks {
    return tasks;
  }
}
