import 'dart:async';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../data/model/product.dart';

class DatabaseService {
  static const String productStore = 'products';
  Database? _db;
  late StoreRef<int, Map<String, dynamic>> _productStore;

  // Singleton pattern
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<void> init() async {
    if (_db == null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final dbPath = '${appDocDir.path}/product_db.db';
      _db = await databaseFactoryIo.openDatabase(dbPath);
      _productStore = intMapStoreFactory.store(productStore);
      Logger().i("Database initialized");
    }
  }


  Future<Database> _ensureDbInitialized() async {
    if (_db == null) {
      await init();
    }
    return _db!;
  }

  // Insert or update a product
  Future<void> insertOrUpdateProduct(Product product) async {
    final db = await _ensureDbInitialized();
    await _productStore.record(product.id).put(db, product.toJson());
  }

  // Get all products from the database
  Future<List<Product>> getAllProducts() async {
    final db = await _ensureDbInitialized();
    final records = await _productStore.find(db);
    Logger().i("Fetched ${records.length} products from the database");
    return records.map((snapshot) => Product.fromJson(snapshot.value)).toList();
  }

  // Delete a product by ID
  Future<void> deleteProduct(int productId) async {
    final db = await _ensureDbInitialized();
    await _productStore.record(productId).delete(db);
  }
}
