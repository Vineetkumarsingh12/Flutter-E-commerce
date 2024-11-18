import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search bar with gradient and focus effect
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: const LinearGradient(
                  colors: [Colors.pinkAccent, Colors.grey],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Focus(
                onFocusChange: (hasFocus) {

                },
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.transparent, // To allow gradient background
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.lightBlue, // Light blue border on focus
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none, // No border when not focused
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Cart Icon with rounded grey background
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey background color
              shape: BoxShape.circle, // Make it rounded
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                // Handle cart button tap here
              },
            ),
          ),
        ],
      ),
    );
  }
}
