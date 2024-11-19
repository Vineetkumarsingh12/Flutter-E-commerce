import 'package:flutter/material.dart';
import '../components/Product_card.dart';
import '../services/api_service.dart';

// Dummy product data to simulate API response
final List<Map<String, dynamic>> dummyProductData = [
  {
    "imageUrl": "assets/images/img_1.png",
    "productName": "Axel Arigato",
    "description": "Clean 90 Triple Sneakers",
    "price": 245.00,
    "isLiked": false,
  },
  {
    "imageUrl": "assets/images/img_2.png",
    "productName": "Maison Margiela",
    "description": "Replica Sneakers",
    "price": 530.00,
    "isLiked": true,
  },
  {
    "imageUrl": "assets/images/img_4.png",
    "productName": "Gia Borghini",
    "description": "RHW Rosie 1 Sandals",
    "price": 740.00,
    "isLiked": false,
  },
  {
    "imageUrl": "assets/images/img_4.png",
    "productName": "Gia Borghini",
    "description": "RHW Rosie 1 Sandals",
    "price": 740.00,
    "isLiked": true,
  },
];



class ProductPage extends StatefulWidget {
   ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
   // String data = 'Loading...';
   //
   // Future<void> fetchData() async {
   //   try {
   //
   //     final ApiService apiService = ApiService(baseUrl: 'https://jsonplaceholder.typicode.com');
   //     final response = await apiService.request(
   //       endpoint: '/posts/1', // The API endpoint
   //       method: 'GET',        // HTTP method
   //     );
   //
   //     // Update the state with the fetched data
   //     print(response);
   //
   //     setState(() {
   //       data = response['title'];
   //     });
   //   } catch (e) {
   //     print(e);
   //     setState(() {
   //       data = 'Error: $e';
   //     });
   //   }
   // }



   // @override
   // void initState() {
   //   super.initState();
   //   fetchData();
   // }

   @override
  Widget build(BuildContext context) {
    // Wrapping in an Expanded to allow GridView to take flexible space
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        // Makes GridView scrollable without interfering with other scrollables
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true, // This allows GridView to fit inside a Column
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65, // Adjust to control height/width ratio
        ),
        itemCount: dummyProductData.length,
        itemBuilder: (context, index) {
          final product = dummyProductData[index];
          return ProductCard(
            imageUrl: product['imageUrl'],
            productName: product['productName'],
            description: product['description'],
            price: product['price'],
            isLiked: product['isLiked'],
            onLikeToggle: () {
              // Handle like button toggle
              print('Liked product ${product['productName']}');
            },
          );
        },
      ),
    );
  }
}
