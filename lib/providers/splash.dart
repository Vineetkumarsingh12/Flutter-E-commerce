import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/authentication/login.dart';
import '../screen/layout.dart';
import 'auth.dart';

class SplashProvider extends ChangeNotifier {
  bool _animate = false;

  bool get animate => _animate;

  Future<void> startAnimation(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _animate = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Check login status and navigate
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkLoginStatus();
    if (authProvider.isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Layout()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}
