import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/authentication/login.dart';
import '../../screen/layout.dart';




class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future<void> startAnimation() async {
    // Start animation after a brief delay
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;

    // Simulate a loading period for splash screen (adjust this as needed)
    await Future.delayed(const Duration(milliseconds: 5000));

    // Check login status before redirecting
    await _checkLoginStatus();
  }

  // Method to check if login data is available
  Future<void> _checkLoginStatus() async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null) {
      // If no email found, redirect to LoginPage
      Get.offAll(() => LoginPage(title: 'Login'));

    } else {
      // If email is found, redirect to HomePage

      print("showing");


      Get.offAll(() => Layout());
    }
  }
}
