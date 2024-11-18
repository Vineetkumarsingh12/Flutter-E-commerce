import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  // List of image paths or URLs
  final List<String> imageList = [
   'assets/images/img_4.png',
    'assets/images/img_3.png',
    'assets/images/img_2.png',
    'assets/images/img_1.png',
    'assets/images/img.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          options: CarouselOptions(
            height: 200.0, // Adjust height as needed
            autoPlay: true, // Auto-scroll the carousel
            enlargeCenterPage: true, // Enlarge current image
            aspectRatio: 2/1,
            viewportFraction: 0.6, // Fraction of the page to show
            autoPlayInterval: const Duration(seconds: 3), // Interval between auto-scroll
          ),
          items: imageList.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            );
          }).toList(),
    );
  }
}
