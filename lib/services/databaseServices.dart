import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../data/model/product.dart';

class DatabaseService {
  static const String productStore = 'products';
  late Database _db;
  late StoreRef<int, Map<String, dynamic>> _productStore;

  // Singleton pattern to ensure a single instance of the database
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  // Initialize the database
  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocDir.path}/product_db.db';
    _db = await databaseFactoryIo.openDatabase(dbPath);
    _productStore = intMapStoreFactory.store(productStore);
  }

  // Insert or update a product
  Future<void> insertOrUpdateProduct(Product product) async {
    await _productStore.record(product.id).put(_db, product.toJson());
  }

  // Get all products from the database
  Future<List<Product>> getAllProducts() async {
    final records = await _productStore.find(_db);
    return records.map((snapshot) => Product.fromJson(snapshot.value)).toList();
  }

  // Delete a product by ID
  Future<void> deleteProduct(int productId) async {
    await _productStore.record(productId).delete(_db);
  }
}
