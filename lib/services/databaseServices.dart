import 'dart:async';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../data/model/product.dart';
import '../data/model/cart.dart';

class DatabaseService {
  static const String productStoreName = 'products';
  static const String cartStoreName = 'cart';
  Database? _db;
  late StoreRef<int, Map<String, dynamic>> _productStore;
  late StoreRef<int, Map<String, dynamic>> _cartStore;

  
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  
  Future<void> init() async {
    if (_db != null) {
      Logger().i("Database already initialized");
      return;
    }

    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocDir.path}/app_db.db';
    _db = await databaseFactoryIo.openDatabase(dbPath);
    _productStore = intMapStoreFactory.store(productStoreName);
    _cartStore = intMapStoreFactory.store(cartStoreName);

    Logger().i("Database initialized with tables: $productStoreName, $cartStoreName");
  }


  Future<Database> _ensureDbInitialized() async {
    if (_db == null) {
      await init();
    }
    return _db!;
  }

  

  Future<void> insertOrUpdateProduct(Product product) async {
    final db = await _ensureDbInitialized();
    await _productStore.record(product.id).put(db, product.toJson());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await _ensureDbInitialized();
    final records = await _productStore.find(db);
    Logger().i("Fetched ${records.length} products from the database");
    return records.map((snapshot) => Product.fromJson(snapshot.value)).toList();
  }

  Future<void> deleteProduct(int productId) async {
    final db = await _ensureDbInitialized();
    await _productStore.record(productId).delete(db);
  }


  Future<void> likeProduct(int productId, bool isLike) async {
    final db = await _ensureDbInitialized();

    var record = await _productStore.record(productId).get(db);

    if(record!=null){
      var mutableRecord = Map<String, dynamic>.from(record);


      mutableRecord['like'] = isLike;

      
      await _productStore.record(productId).put(db, mutableRecord);
    }

  }


  Future<Product?> singleProduct(int id) async {
    final db = await _ensureDbInitialized();

    final record = await _productStore.record(id).get(db);
    if (record != null) {
      return Product.fromJson(record);
    }
    return null;
  }


  

  Future<void> insertOrUpdateCartItem(CartItem cartItem) async {
    final db = await _ensureDbInitialized();
    await _cartStore.record(cartItem.id).put(db, cartItem.toJson());
  }

  Future<List<CartItem>> getAllCartItems() async {
    final db = await _ensureDbInitialized();
    final records = await _cartStore.find(db);
    return records.map((snapshot) {
      final cartItem = CartItem.fromJson(snapshot.value);
      cartItem.id = snapshot.key;
      return cartItem;
    }).toList();
  }

  Future<void> deleteCartItem(int productId) async {
    final db = await _ensureDbInitialized();
    await _cartStore.record(productId).delete(db);
  }

  Future<void> deleteAllCartItem() async{
    final db=await _ensureDbInitialized();
    await _cartStore.delete(db);
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    final db = await _ensureDbInitialized();
    final cartItemRecord = await _cartStore.record(productId).get(db);
    if (cartItemRecord != null) {
      final updatedCartItem = CartItem.fromJson(cartItemRecord);
      updatedCartItem.quantity = quantity;
      await _cartStore.record(productId).put(db, updatedCartItem.toJson());
    }
  }
}
