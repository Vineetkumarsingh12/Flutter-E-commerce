import 'package:flutter/material.dart';

import '../data/model/cart.dart';

import '../services/databaseServices.dart';


class CartProvider extends ChangeNotifier {
  // Map to hold the cart items (id and count)
  Map<int, int> cart = {};


  final  DatabaseService  _db= DatabaseService();





  CartProvider() {
    _initializeCart();
  }


  Future<void> _initializeCart() async {
    await _db.init();
    final cartItems = await _db.getAllCartItems();
    for (var item in cartItems) {
      cart[item.id] = item.quantity;
    }
    notifyListeners();
  }

  Future<void> addToCart({required int id,required num price}) async {
    if (cart.containsKey(id)) {

      cart[id] = cart[id]! + 1;

    } else {

      cart[id] = 1;

    }


    await _db.insertOrUpdateCartItem((CartItem(id: id, quantity: cart[id]!)));
    notifyListeners();
  }


  Future<void> removeFromCart({required int id,required num price}) async {
    if (cart.containsKey(id) && cart[id]! > 0) {

      cart[id] = cart[id]! - 1;


      if (cart[id] == 0) {
        cart.remove(id);
        await _db.deleteCartItem(id);
      } else {
        await _db.insertOrUpdateCartItem(CartItem(id: id, quantity: cart[id]!));
      }


      notifyListeners();
    }
  }


  Future<void> updateCart({required int id, required int count,required num price}) async {
    if (count > 0) {
      cart[id] = count;
      await _db.updateCartItemQuantity(id,  count);
    } else {
      cart.remove(id);
      await _db.deleteProduct(id);
    }


    notifyListeners();
  }
}
