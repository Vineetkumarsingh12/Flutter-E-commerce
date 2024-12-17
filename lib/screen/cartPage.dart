import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cartTile.dart';
import '../data/model/product.dart';
import '../providers/cart.dart';
import '../services/databaseServices.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // Access the CartProvider from the context
    final cartProvider = Provider.of<CartProvider>(context);

    // Retrieve cart data
    final data = cartProvider.cart;

    // Fetch products based on the cart's product IDs
    final productsFuture = Future.wait(
      data.entries.map((entry) async {
        final product = await DatabaseService().singleProduct(entry.key);
        return MapEntry(product, entry.value);
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: FutureBuilder<List<MapEntry<Product, int>>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final productEntry = products[index];
              final product = productEntry.key;
              final quantity = productEntry.value;

              return CartTile(product: product, quantity: quantity);
            },
          );
        },
      ),
        backgroundColor: Colors.grey[200]
    );
  }
}
