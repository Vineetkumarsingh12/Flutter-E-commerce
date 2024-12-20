import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../data/model/product.dart';
import '../providers/product.dart';
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
    List<Product> fetchedProducts = jsonList.map<dynamic>((json) {
      try {
        return Product.fromJson(json);
      } catch (e) {
        Logger().e('Error parsing product JSON: $e');
        return null;
      }
    }).whereType<Product>().toList();

    return fetchedProducts;
  }

  Future<void> insertIntoDb(List<Product> products) async {
    for (var product in products) {
      await _databaseService.insertOrUpdateProduct(product);
    }
  }

  Future<void> refresh(bool flag) async {


    if ( flag == false) {
      fetchFromApi().then((products) => insertIntoDb(products));
    }
  }
}