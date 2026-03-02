// utils/provider.dart
import 'package:flutter/material.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/utils/prefs_helper.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItem> todos = TodoItem.tasks();
  List<TodoItem> _tasks = [];
  List<TodoItem> get tasks => _tasks;

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  TodoProvider() {
    _loadLocale();
    _loadTasks();
  }

  Future<void> _loadLocale() async {
    String? savedLang = await PrefsHelper.getLanguage();
    if (savedLang != null) {
      _locale = Locale(savedLang);
      notifyListeners();
    }
  }

  Future<void> _loadTasks() async {
    _tasks = await PrefsHelper.getTasks();
    notifyListeners();
  }

  Future<void> loadTasksFromPrefs() async {
    await _loadTasks();
  }

  Future<void> saveTasks(TodoItem todoItem) async {
    _tasks.add(todoItem);
    await PrefsHelper.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteTask(TodoItem task) async {
    _tasks.removeWhere((t) => t.id == task.id);
    await PrefsHelper.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> saveAllTasks() async {
    await PrefsHelper.saveTasks(_tasks);
  }

  void toggleTask(int id, bool value) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isDone = value;
      await PrefsHelper.saveTasks(_tasks);
      notifyListeners();
    }
  }

  void setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    await PrefsHelper.saveLanguage(newLocale.languageCode);
    notifyListeners();
  }
}
