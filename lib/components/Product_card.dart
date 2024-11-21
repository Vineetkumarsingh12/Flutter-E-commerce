import 'package:ecommerce/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/cart.dart';

// ProductCard widget to display a single product's details
class ProductCard extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String description;
  final num price;
  final Rating rating;
  final bool isLiked;
  final VoidCallback onLikeToggle;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.isLiked,
    required this.onLikeToggle,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartCount = cartProvider.cart[id] ?? 0; // Use the item count from provider

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack to overlay the like button on top of the product image
          Stack(
            children: [
              // Product Image with reduced height
              AspectRatio(
                aspectRatio: 1.2, // Adjusted aspect ratio to make it less tall
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              // Positioned like button at the top-right corner
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
                  ),
                  onPressed: onLikeToggle,
                  splashRadius: 20, // Adjust splash radius if needed
                  iconSize: 24, // Adjust icon size if needed
                ),
              ),
              // Positioned cart controls at the bottom-right corner
              Positioned(
                top: 2,
                left: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      // Decrement Button
                      IconButton(
                        onPressed: () {
                          cartProvider.removeFromCart(id: id);
                        },
                        icon: const Icon(Icons.remove, color: Colors.black),
                        splashRadius: 20,
                        iconSize: 20,
                      ),
                      // Vertical Separator
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      // Item Count Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Vertical Separator
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      // Increment Button
                      IconButton(
                        onPressed: () {
                          cartProvider.addToCart(id: id);
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                        splashRadius: 20,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Product Details - compacted layout
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Title
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 4), // Reduced padding
                child: Text(
                  title,
                  maxLines: 1, // Show only one line of title
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15, // Slightly smaller font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Product Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  maxLines: 1, // Show only one line for description to save space
                  overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                  style: const TextStyle(
                    fontSize: 13, // Smaller font size for description
                    color: Colors.grey,
                  ),
                ),
              ),
              // Price and Rating Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Reduced vertical padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Price
                    Text(
                      '\₹${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15, // Slightly smaller font size
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    // Product Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14, // Slightly smaller star icon
                        ),
                        const SizedBox(width: 2), // Reduced spacing
                        Text(
                          '${rating.rate} (${rating.count})',
                          style: const TextStyle(
                            fontSize: 13, // Smaller font size
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
