import 'dart:convert';
import 'package:ecommerce/services/databaseServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoggedIn = false;

  UserModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserJson = prefs.getString('user');

    if (storedUserJson != null) {

      // Decode the stored JSON string into a Map<String, dynamic>
      Map<String, dynamic> storedUserMap = jsonDecode(storedUserJson);

      // Convert the Map into a UserModel
      UserModel savedUser = UserModel.fromJson(storedUserMap);

      // Check if the saved user matches the provided email and password
      if (savedUser.email == email && savedUser.password == password) {
        _user = savedUser;
        _isLoggedIn = true;
        print("Login successful!");
        notifyListeners();
      } else {
        print("Invalid username or password");
        throw Exception('Invalid username or password');
      }
    } else {
      throw Exception('User not found');
    }
  }


  Future<void> isLoggedInf()  async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserJson = prefs.getString('user');

    if(storedUserJson!=null){
      print("hell******************");
      _isLoggedIn=true;
    }


  }

  Future<void> signup(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel newUser = UserModel(email: email, password: password);

    // Convert the UserModel to JSON string and store it
    String userJson = jsonEncode(newUser.toJson());

    await prefs.setString('user', userJson);
    _user = newUser;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('user');
    final DatabaseService db=await DatabaseService();
    await db.deleteAllCartItem();

    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
