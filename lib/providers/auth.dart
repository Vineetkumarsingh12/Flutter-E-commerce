import 'package:flutter/material.dart';

import '../services/auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    await _authService.saveCredentials(email, password);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final email = await _authService.getSavedEmail();
    _isAuthenticated = email != null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.clearCredentials();
    _isAuthenticated = false;
    notifyListeners();
  }
}
