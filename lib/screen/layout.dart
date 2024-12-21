import 'package:ecommerce/screen/profilePage.dart';
import 'package:ecommerce/screen/serach.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../components/drawer.dart';
import 'home.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<Layout> {
  int _currentIndex = 0;

  // List of pages to navigate
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  // Method to handle navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Our E-commerce App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      endDrawer:customDrawer() ,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Blur effect
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2), // Semi-transparent white
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3), // Border for glass effect
                  width: 1.0,
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent, // Keep transparent to show glass effect
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                elevation: 0,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
