import 'dart:ui';

import 'package:ecommerce/components/cartIncrementDecrement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/data/model/product.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

import '../components/cairosal.dart';
import '../providers/cart.dart';
import '../services/databaseServices.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String description;
  final num price;
  final Rating rating;
  final bool isLiked;
  final Function(int, bool) onLikeToggle;

  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.isLiked,
    required this.onLikeToggle,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final List<double> availableSizes = [39, 39.5, 40, 40.5, 41];
  double selectedSize = 39;

  late DatabaseService db;
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    db = DatabaseService();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int count = cartProvider.cart[widget.id] ?? 0;

    List<String> imageList = [];
    for (int i = 0; i < 3; i++) {
      imageList.add(widget.image);
    }

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
            icon: Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.grey, 
            ),
            onPressed: () async {
              
              await widget.onLikeToggle(widget.id, !isLiked);

              
              setState(() {
                isLiked = !isLiked; 
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: screenHeight - 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCarousel(imageList: imageList),
                  const SizedBox(height: 20),
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
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                color: selectedSize == size
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    offset: Offset(0, -5),
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
                  count == 0
                      ? ElevatedButton.icon(
                    onPressed: () {
                      cartProvider.addToCart(id: widget.id, price: widget.price);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('Add to cart'),
                  )
                      : CartIncrementDecrement(id: widget.id, price: widget.price),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
