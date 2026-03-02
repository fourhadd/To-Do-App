// pages/auth/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:todo/utils/prefs_helper.dart';
import 'package:todo/l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoggedIn = false;

  String get username => _username;
  bool get isLoggedIn => _isLoggedIn;

  void updateUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  // LOGIN
  Future<String?> login(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final users = await PrefsHelper.getUserCredentials();

    if (_username.isEmpty || _password.isEmpty) {
      return t.errorUsernamePasswordEmpty;
    }

    if (users.containsKey(_username) && users[_username] == _password) {
      _isLoggedIn = true;
      await PrefsHelper.setLoggedIn(true);
      notifyListeners();
      return null;
    }

    return t.errorInvalidCredentials;
  }

  // REGISTER
  Future<String?> register(BuildContext context) async {
    final t = AppLocalizations.of(context)!;

    if (_username.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      return t.errorEmptyFields;
    }

    if (_password != _confirmPassword) {
      return t.errorPasswordMismatch;
    }

    if (_password.length < 6) {
      return t.errorPasswordShort;
    }

    await PrefsHelper.saveUserCredentials(_username, _password);
    _isLoggedIn = true;
    await PrefsHelper.setLoggedIn(true);
    notifyListeners();
    return null;
  }

  // LOGOUT
  Future<void> logout() async {
    _isLoggedIn = false;
    _username = '';
    _password = '';
    _confirmPassword = '';
    await PrefsHelper.setLoggedIn(false);
    notifyListeners();
  }

  // FORM FILL CHECK
  bool isFormFilled({bool isRegister = false}) {
    if (isRegister) {
      return _username.isNotEmpty &&
          _password.isNotEmpty &&
          _confirmPassword.isNotEmpty;
    } else {
      return _username.isNotEmpty && _password.isNotEmpty;
    }
  }
}
