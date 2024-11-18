import 'package:flutter/material.dart';
import '../data/categrory.dart'; // Corrected the file path

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Card(
                    shape: const CircleBorder(),
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        category['image'],
                        width: 70, // Set the width of the image
                        height: 70, // Set the height of the image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
