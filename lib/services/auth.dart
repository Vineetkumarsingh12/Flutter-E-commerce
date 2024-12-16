import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  static Future<String?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
