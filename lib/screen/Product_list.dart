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
