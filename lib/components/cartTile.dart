import 'package:flutter/material.dart';
import '../data/model/product.dart';
import '../screen/Product_details.dart';
import 'cartIncrementDecrement.dart';
import 'imageCache.dart';

class CartTile extends StatefulWidget {
  final Product product;
  final int quantity;

  const CartTile({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              title: widget.product.title,
              image: widget.product.image,
              rating: widget.product.rating,
              description: widget.product.description,
              id: widget.product.id,
              isLiked: true,
              price: widget.product.price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFCE4EC), Color(0xFFE1BEE7)], // Light pink and purple gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:  buildCachedNetworkImage(
                imageUrl: widget.product.image,
                cacheDurationInDays: 1,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            widget.product.title,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            '₹ ${(widget.product.price).toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          trailing: CartIncrementDecrement(
            id: widget.product.id,
            price: widget.product.price,
          ),
        ),
      ),
    );
  }
}
