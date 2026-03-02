// utils/prefs_helper.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todo/models/model_todo.dart';

class PrefsHelper {
  static const _onboardingKey = 'onboardingComplete';
  static const _loginKey = 'isLoggedIn';
  static const _usersKey = 'users';
  static const _languageKey = 'language';
  static const _tasksKey = 'tasks';

  // ONBOARDING
  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingComplete(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, value);
  }

  // LOGIN STATUS
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, value);
  }

  // MULTI-USER CREDENTIALS
  static Future<void> saveUserCredentials(
    String username,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> users = {};

    final existing = prefs.getString(_usersKey);
    if (existing != null) {
      users = Map<String, String>.from(jsonDecode(existing));
    }

    users[username] = password;
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<Map<String, String>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_usersKey);
    if (data != null) {
      return Map<String, String>.from(jsonDecode(data));
    }
    return {};
  }

  // TASKS
  static Future<void> saveTasks(List<TodoItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = TodoItem.encodeTasks(tasks);
    await prefs.setString(_tasksKey, encoded);
  }

  static Future<List<TodoItem>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? encoded = prefs.getString(_tasksKey);
    if (encoded == null) return [];
    List<dynamic> decoded = json.decode(encoded);
    return decoded.map((e) => TodoItem.fromJson(e)).toList();
  }

  // GENERIC BOOL / STRING
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  // LANGUAGE
  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, langCode);
  }

  static Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey);
  }
}
