// auth_service/auth_service.dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class AuthService {
  static const String _loggedInKey = "isLoggedIn";
  static const String _userEmailKey = "userEmail";

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  // Future<void> login(String email, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(_loggedInKey, true);
  //   await prefs.setString(_userEmailKey, email);
  // }

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(_loggedInKey, false);
  //   await prefs.remove(_userEmailKey);
  // }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }
}

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
}
