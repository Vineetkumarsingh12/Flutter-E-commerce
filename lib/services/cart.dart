import 'dart:async';
import 'package:ecommerce/data/model/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class CartDb {
  static const String cartStore = 'cart';
  late Database _db;
  late StoreRef<int, Map<String, dynamic>> _cartStore;

  // Singleton pattern to ensure a single instance of the database
  static final CartDb _instance = CartDb._internal();
  factory CartDb() => _instance;

  CartDb._internal();

  // Initialize the database
  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocDir.path}/cart_db.db';
    _db = await databaseFactoryIo.openDatabase(dbPath);
    _cartStore = intMapStoreFactory.store(cartStore);
  }

  // Insert or update a product
  Future<void> insertOrUpdateProduct(CartItem cartItem) async {
    await _cartStore.record(cartItem.id).put(_db, cartItem.toJson());
  }

  // Get all products from the database
  Future<List<CartItem>> getAllCartItems() async {
    final records = await _cartStore.find(_db);
    return records.map((snapshot) {
      final cartItem = CartItem.fromJson(snapshot.value);
      cartItem.id = snapshot.key;
      return cartItem;
    }).toList();
  }

  // Delete a product by ID
  Future<void> deleteProduct(int productId) async {
    await _cartStore.record(productId).delete(_db);
  }

  // Update a single cart item by ID and quantity
  Future<void> updateSingleCartItem(int productId, int quantity) async {
    final cartItemRecord = await _cartStore.record(productId).get(_db);
    if (cartItemRecord != null) {
      final updatedCartItem = CartItem.fromJson(cartItemRecord);
      updatedCartItem.quantity = quantity;
      await _cartStore.record(productId).put(_db, updatedCartItem.toJson());
    }
  }
}
