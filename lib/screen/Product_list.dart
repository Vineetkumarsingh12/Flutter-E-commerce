import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/Product_card.dart';
import '../data/model/product.dart';
import '../services/api_service.dart';

// Dummy product data to simulate API response

// = [
//   {
//     "imageUrl": "assets/images/img_1.png",
//     "productName": "Axel Arigato",
//     "description": "Clean 90 Triple Sneakers",
//     "price": 245.00,
//     "isLiked": false,
//   },
//   {
//     "imageUrl": "assets/images/img_2.png",
//     "productName": "Maison Margiela",
//     "description": "Replica Sneakers",
//     "price": 530.00,
//     "isLiked": true,
//   },
//   {
//     "imageUrl": "assets/images/img_4.png",
//     "productName": "Gia Borghini",
//     "description": "RHW Rosie 1 Sandals",
//     "price": 740.00,
//     "isLiked": false,
//   },
//   {
//     "imageUrl": "assets/images/img_4.png",
//     "productName": "Gia Borghini",
//     "description": "RHW Rosie 1 Sandals",
//     "price": 740.00,
//     "isLiked": true,
//   },
// ];

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.endpoint});

  final String endpoint;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> productData = [];

  // Fetch data from the API using the endpoint.
  Future<void> fetchData() async {
    try {
      final ApiService apiService =
          ApiService(baseUrl: 'https://fakestoreapi.com');
      final response = await apiService.request(
        endpoint: widget.endpoint,
        method: 'GET',
      );


      final jsonList = response;

      ///     reserach
      Logger logger = Logger(
        printer: PrettyPrinter(methodCount: 0, colors: true)
      );


      logger.i('DUMMY: $jsonList' );

      setState(() {
        try {
          productData = jsonList
              .map((productJson) => Product.fromJson(productJson))
              .toList();
        } catch(e) {
          print("DATA-PARSING-ERROR: ${e.toString()}");
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: productData.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Display a loading indicator while data is being fetched
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // Allow the grid to fit within the column
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Adjust to control height/width ratio
              ),
              itemCount: productData.length,
              itemBuilder: (context, index) {
                final product = productData[index];
                return ProductCard(
                  id: product.id,
                  image: product.image,
                  title: product.title,
                  description: product.description,
                  price: product.price ?? 0.0,
                  rating: product.rating,
                  isLiked: Random().nextBool(),
                  onLikeToggle: () {
                    // Handle like button toggle
                    print('Liked product ${product.title}');
                  },
                );
              },
            ),
    );
  }
}
