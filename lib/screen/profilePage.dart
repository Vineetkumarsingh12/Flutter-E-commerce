import 'package:ecommerce/providers/auth.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/screen/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Dummy Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),

            // Email ID
            Text(
              authProvider.user?.email ?? "No email available",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items in Cart (${cartProvider.cart.length}):",
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Cart Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                  child: const Text("Go to Cart"),
                ),
              ],
            ),
            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => products()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Continue Shopping",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
