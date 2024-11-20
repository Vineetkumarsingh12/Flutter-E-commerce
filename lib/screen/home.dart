import 'package:flutter/material.dart';
import '../components/navBar.dart';
import '../components/cairosal.dart';
import '../components/categoryList.dart';
import 'product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(),
            ImageCarousel(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CategoryList(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Text(
                "Products",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProductPage(endpoint: "/products"), // Use the corrected ProductPage
          ],
        ),
      ),
    );
  }
}
