import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // id and count of particular product
  Map<int, int> cart;

  // Initialize the cart as an empty map in the constructor
  CartProvider({Map<int, int>? initialCart}) : cart = initialCart ?? {};

  // Method to add a product to the cart
  void addToCart({required int id}) {
    if (cart.containsKey(id)) {
      // Increment the quantity if the product is already in the cart
      cart[id] = cart[id]! + 1;
    } else {
      // Add the product to the cart with a quantity of 1 if not already present
      cart[id] = 1;
    }
    notifyListeners();
  }

  // Method to remove a product from the cart
  void removeFromCart({required int id}) {
    if (cart.containsKey(id) && cart[id]! > 0) {
      // Decrement the quantity if it's greater than 0
      cart[id] = cart[id]! - 1;
      notifyListeners();

      // Remove the product from the cart if the quantity becomes 0
      if (cart[id] == 0) {
        cart.remove(id);
      }
    }
  }
}
