import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/Product_card.dart';
import '../data/model/product.dart';
import '../services/api_service.dart';
import '../services/databaseServices.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.endpoint});

  final String endpoint;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> productData = [];
  final DatabaseService _databaseService = DatabaseService();

  // Fetch data from the API using the endpoint
  Future<void> fetchDataFromApi() async {
    try {
      final apiService = ApiService(baseUrl: 'https://fakestoreapi.com');
      final jsonList = await apiService.request(endpoint: widget.endpoint, method: 'GET');

      Logger().i('API Response: $jsonList');

      final fetchedProducts = jsonList.map<dynamic>((json) {
        try {
          return Product.fromJson(json);
        } catch (e) {
          Logger().e('Error parsing product JSON: $e');
          return null; // Skip invalid products
        }
      }).whereType<Product>().toList();

      setState(() {
        productData = fetchedProducts;
      });

      // Save fetched products to the database
      for (var product in fetchedProducts) {
        await _databaseService.insertOrUpdateProduct(product);
      }
    } catch (e) {
      Logger().e('Error fetching data: $e');
    }
  }

  // Fetch data from the local Sembast database
  Future<void> fetchDataFromDb() async {
    final productsFromDb = await _databaseService.getAllProducts();
    setState(() {
      productData = productsFromDb;
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize database and fetch data
    _databaseService.init().then((_) {
      fetchDataFromDb().then((_) {
        if (productData.isEmpty) {
          fetchDataFromApi();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: productData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.62,
        ),
        itemCount: productData.length,
        itemBuilder: (context, index) {
          final product = productData[index];
          return ProductCard(
            id: product.id,
            image: product.image,
            title: product.title,
            description: product.description,
            price: product.price,
            rating: product.rating,
            isLiked: Random().nextBool(),
            onLikeToggle: () {
              Logger().i('Liked product: ${product.title}');
            },
          );
        },
      ),
    );
  }
}
