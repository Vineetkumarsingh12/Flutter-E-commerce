import 'package:ecommerce/screen/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/splash.dart';
import '../../providers/auth.dart';
import '../authentication/login.dart';

class Splashh extends StatelessWidget {
  Splashh({super.key});

  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 3), () async {
      
      AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
         await authProvider.isLoggedInf();
      bool isLoggedIn = authProvider.isLoggedIn;


      print(isLoggedIn);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isLoggedIn ?  Layout() :  LoginPage()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          
          Align(
            alignment: const Alignment(0, -0.8),
            child: Image.asset(tSplashTopIcon),
          ),

          
          Align(
            alignment: const Alignment(0, -0.4),
            child: Text(
              appNameTagLine,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: 40,
            left: 50,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: 1,
              child: Image.asset(
                tMainIcon,
                width: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
