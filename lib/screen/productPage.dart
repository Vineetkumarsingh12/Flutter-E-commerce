import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../components/Product_card.dart';

class Ppage extends StatefulWidget {
  final productData;
  const Ppage({super.key,required this.productData});

  @override
  State<Ppage> createState() => _PpageState();
}

class _PpageState extends State<Ppage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: widget.productData.isEmpty
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
            itemCount: widget.productData.length,
            itemBuilder: (context, index) {
              final product = widget.productData[index];
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
