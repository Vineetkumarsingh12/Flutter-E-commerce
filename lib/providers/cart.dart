import 'package:flutter/material.dart';

import '../data/model/cart.dart';
import '../services/cart.dart';


class CartProvider extends ChangeNotifier {
  // Map to hold the cart items (id and count)
  Map<int, int> cart = {};

  // Reference to the CartDb instance
  final CartDb _cartDb = CartDb();


  CartProvider() {
    _initializeCart();
  }

  // Private method to initialize the cart
  Future<void> _initializeCart() async {
    await _cartDb.init(); // Ensure the database is initialized
    final cartItems = await _cartDb.getAllCartItems();
    for (var item in cartItems) {
      cart[item.id] = item.quantity;
    }
    notifyListeners();
  }

  // Add a product to the cart
  Future<void> addToCart({required int id}) async {
    if (cart.containsKey(id)) {
      // Increment the quantity if the product is already in the cart
      cart[id] = cart[id]! + 1;
    } else {
      // Add the product to the cart with a quantity of 1 if not already present
      cart[id] = 1;
    }
    await _cartDb.insertOrUpdateProduct(CartItem(id: id, quantity: cart[id]!));
    notifyListeners();
  }

  // Remove a product from the cart
  Future<void> removeFromCart({required int id}) async {
    if (cart.containsKey(id) && cart[id]! > 0) {
      // Decrement the quantity if it's greater than 0
      cart[id] = cart[id]! - 1;

      // Update the database
      if (cart[id] == 0) {
        cart.remove(id);
        await _cartDb.deleteProduct(id);
      } else {
        await _cartDb.insertOrUpdateProduct(CartItem(id: id, quantity: cart[id]!));
      }
      notifyListeners();
    }
  }

  // Update a product's quantity in the cart
  Future<void> updateCart({required int id, required int count}) async {
    if (count > 0) {
      cart[id] = count;
      await _cartDb.insertOrUpdateProduct(CartItem(id: id, quantity: count));
    } else {
      cart.remove(id);
      await _cartDb.deleteProduct(id);
    }
    notifyListeners();
  }
}
