import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/services/task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  bool isLoading = false;
  final List<TaskModel> _allTasks = [];

  // Load tasks from the database
  Future<void> loadTasks() async {
    tasks = await TaskDatabase.loadTasks();
    _allTasks.addAll(tasks);
    notifyListeners();
  }

  // Save tasks to the database
  Future<void> saveTasks() async {
    await TaskDatabase.saveTasks(tasks);
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
