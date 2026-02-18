import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/model_todo.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItem> todos = TodoItem.tasks();
  List<TodoItem> _tasks = [];
  List<TodoItem> get tasks => _tasks;

  Future<void> loadTasksFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString("tasks");
    final jsonDecodedData = rawData == null
        ? null
        : json.decode(rawData) as List<dynamic>;
    final List<TodoItem> loadedTasks = jsonDecodedData == null
        ? []
        : jsonDecodedData.map((e) => TodoItem.fromJson(e)).toList();

    _tasks = loadedTasks;
    notifyListeners();
  }

  Future<void> saveTasks(TodoItem todoItem) async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString("tasks");
    final jsonDecodedData = rawData == null
        ? null
        : json.decode(rawData) as List<dynamic>;
    final List<TodoItem> tasks = jsonDecodedData == null
        ? []
        : jsonDecodedData.map((e) => TodoItem.fromJson(e)).toList();

    tasks.add(todoItem);
    final jsonEncodedData = TodoItem.encodeTasks(tasks);
    // log(jsonEncodedData.toString());
    await prefs.setString("tasks", jsonEncodedData.toString());
    notifyListeners();
  }

  Future<void> deleteTask(TodoItem task) async {
    _tasks.removeWhere((t) => t.id == task.id);
    final prefs = await SharedPreferences.getInstance();
    final jsonEncodedData = TodoItem.encodeTasks(_tasks);
    await prefs.setString("tasks", jsonEncodedData);
    notifyListeners();
  }

  Future<void> saveAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonEncodedData = TodoItem.encodeTasks(_tasks);
    await prefs.setString("tasks", jsonEncodedData);
  }

  void toggleTask(int id, bool value) {
    int index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isDone = value;
      saveAllTasks();
      notifyListeners();
    }
  }
}
