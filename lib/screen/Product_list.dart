import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../components/Product_card.dart';
import '../providers/product.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.products.isEmpty && !productProvider.isData) {
      productProvider.getProducts();
    }

    final productData = productProvider.products;

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
