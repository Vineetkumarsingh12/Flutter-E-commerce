import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartIncrementDecrement extends StatelessWidget {
  CartIncrementDecrement({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartCount = cartProvider.cart[id] ?? 0;

    return Positioned(
      top: 4,
      left: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            
            SizedBox(
              width: 24,
              height: 24, 
              child: IconButton(
                onPressed: () {
                  cartProvider.removeFromCart(id: id);
                },
                icon: const Icon(Icons.remove, color: Colors.black),
                splashRadius: 15,
                iconSize: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            
            Container(
              height: 1,
              width: 24.0, 
              color: Colors.grey.shade300,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0), 
              child: Text(
                '$cartCount',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            
            Container(
              height: 1,
              width: 24.0, 
              color: Colors.grey.shade300,
            ),
            
            SizedBox(
              width: 24,
              height: 24, 
              child: IconButton(
                onPressed: () {
                  cartProvider.addToCart(id: id);
                },
                icon: const Icon(Icons.add, color: Colors.black),
                splashRadius: 15,
                iconSize: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
