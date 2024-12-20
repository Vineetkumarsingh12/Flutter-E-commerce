import 'package:logger/logger.dart';
import '../data/model/product.dart';
import '../services/api_service.dart';
import '../services/databaseServices.dart';

class Refresh {
  final DatabaseService _databaseService = DatabaseService();

  Refresh() {
    _databaseService.init();
  }

  Future<List<Product>> fetchFromApi() async {
    final apiService = ApiService(baseUrl: 'https://fakestoreapi.com');
    final jsonList = await apiService.request(endpoint: '/products', method: 'GET');

    Logger().i('API Response: $jsonList');
    return jsonList.map<dynamic>((json) {
      try {
        return Product.fromJson(json);
      } catch (e) {
        Logger().e('Error parsing product JSON: $e');
        return null;
      }
    }).whereType<Product>().toList();
  }

  Future<void> insertIntoDb(List<Product> products) async {
    for (var product in products) {
      await _databaseService.insertOrUpdateProduct(product);
    }
  }

  Future<void> refresh(bool flag) async {
    if (!flag) {
      final products = await fetchFromApi();
      await insertIntoDb(products);
    }
  }
}