import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}