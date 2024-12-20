import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/Product_card.dart';
import '../providers/product.dart';

class ProductPage extends StatefulWidget {
  final String? category;

  ProductPage({Key? key, this.category}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    // Initialize the ProductProvider
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    if (!productProvider.isData) {
      Logger().i("Initializing ProductProvider and fetching products...");
      productProvider.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the updated productProvider instance
    productProvider = Provider.of<ProductProvider>(context);
    final productData = widget.category == null
        ? productProvider.products
        : productProvider.products
        .where((product) => product.category == widget.category)
        .toList();

    Logger().i("category  ${widget.category}");

    Logger().i("ProductPage: ${productData.length} products found.");

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: productData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            // Set shrinkWrap to true to avoid unbounded height issues
            shrinkWrap: true,
            // Disable scrolling of the GridView if inside another scrollable widget
            physics: const NeverScrollableScrollPhysics(),
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
          );
        },
      ),
    );
  }
}
