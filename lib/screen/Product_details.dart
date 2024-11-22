import 'package:flutter/material.dart';
import 'package:ecommerce/data/model/product.dart';

import '../components/cairosal.dart';

class ProductDetailsPage extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String description;
  final num price;
  final Rating rating;
  final bool isLiked;

  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    List<String> imageList=[];
    for(int i=0;i<3;i++){
      imageList.add(image);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(imageList:imageList),
              ],
            ),

        ),
      );
  }
}
