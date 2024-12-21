import 'package:ecommerce/services/databaseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../components/Product_card.dart';


class Ppage extends StatefulWidget {
  final productData;
  const Ppage({super.key, required this.productData});

  @override
  State<Ppage> createState() => _PpageState();
}

class _PpageState extends State<Ppage> {
  @override
  Widget build(BuildContext context) {
    final DatabaseService productDb = DatabaseService();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: widget.productData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
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
                isLiked: product.like,
                onLikeToggle: (int id, bool isLike) async {
                  
                  await productDb.likeProduct(id, isLike);

                  
                  setState(() {
                    widget.productData[index].like = isLike;
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
