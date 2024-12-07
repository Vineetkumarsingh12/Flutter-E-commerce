import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/splash.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.8),
            child: const Text('App Icon', style: TextStyle(fontSize: 40)),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            bottom: splashProvider.animate ? 50 : -100,
            child: const Text('Welcome!'),
          ),
        ],
      ),
    );
  }
}
