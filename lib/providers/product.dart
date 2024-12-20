import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../data/model/product.dart';
import '../data/refresh.dart';
import '../services/databaseServices.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isData = false;

  Future<void> getProducts() async {
    Logger().i("Fetching products inside ProductProvider");


    await Refresh().refresh(isData);


    final dbProducts = await DatabaseService().getAllProducts();
    products = dbProducts;

    Logger().i("Products fetched from database: ${products.length}");
    isData = true;

    notifyListeners();
  }
}
