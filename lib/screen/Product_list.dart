import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/Product_card.dart';
import '../providers/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();

      productProvider = Provider.of<ProductProvider>(context, listen: false);
      if (!productProvider.isData) {
        productProvider.getProducts();
      }

  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productData = productProvider.products;

    Logger().i("ProductPage: ${productData.length} products");

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
