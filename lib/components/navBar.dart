import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/cartPage.dart';
import '../screen/serach.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
   
    final cartProvider = Provider.of<CartProvider>(context);
    final cartCount = cartProvider.cart.length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()), 
                );
              },
              child: Container(
                height: 50.0, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                    colors: [Colors.pinkAccent, Colors.grey],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                    const Text(
                      'Search...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], 
                  shape: BoxShape.circle, 
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()), 
                    );
                  },
                ),
              ),
              
              if (cartCount > 0) 
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 10, 
                    backgroundColor: Colors.black,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
