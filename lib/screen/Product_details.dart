import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/data/model/product.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../components/cairosal.dart';

class ProductDetailsPage extends StatefulWidget {
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
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final List<double> availableSizes = [39, 39.5, 40, 40.5, 41];

  // Use a state variable for the selected size
  double selectedSize = 39;

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [];
    for (int i = 0; i < 3; i++) {
      imageList.add(widget.image);
    }

    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: widget.isLiked ? Colors.red : Colors.grey),
            onPressed: () {
              // Add favorite action
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable content with a minimum height set to the screen height
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: screenHeight - 100, // Subtract the height of the fixed bottom bar if needed
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel
                  ImageCarousel(imageList: imageList),
                  const SizedBox(height: 20),

                  // Product Info Container with shadow only at the top
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, -5), // Shadow downwards (only top)
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title & Rating
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Rating Stars
                            Text('${widget.rating.rate}'),
                            const SizedBox(width: 8),
                            StarRating(rating: widget.rating.rate.toDouble()),

                            const SizedBox(width: 8),
                            Text(
                              '(${widget.rating.count} Reviews)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Size Selector
                        Text(
                          'Size',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: availableSizes.map((size) {
                            return ChoiceChip(
                              label: Text(size.toString()),
                              selected: selectedSize == size,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) selectedSize = size;
                                });
                              },
                              selectedColor: Colors.green,
                              backgroundColor: Colors.grey.shade200,
                              labelStyle: TextStyle(
                                color: selectedSize == size ? Colors.white : Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 100), // Add some space at the bottom
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed Positioned element at the bottom for Price and Add to Cart Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, -5), // Shadow upwards (only top)
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '\₹${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add to cart action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('Add to cart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
