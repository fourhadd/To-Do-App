import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model_todo.dart';
import 'dart:convert';

class PrefsHelper {
  static Future<void> setOnboardingComplete(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', value);
  }

  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> saveUserCredentials(
    String username,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'username': username, 'password': password};
  }

  static Future<void> saveTasks(List<TodoItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = TodoItem.encodeTasks(tasks);
    await prefs.setString('tasks', encoded);
  }

  static Future<List<TodoItem>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? encoded = prefs.getString('tasks');
    if (encoded == null) return [];
    List<dynamic> decoded = json.decode(encoded);
    return decoded.map((e) => TodoItem.fromJson(e)).toList();
  }

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
}
