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
  late Future<List<MapEntry<Product, int>>> productsFuture;

  int itemCount = 0;

  // Address field
  String _address = 'Universal trade tower FieldAssist';
  final TextEditingController _addressController = TextEditingController();

  // Payment method selection
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();

    // Fetch cart data when the widget is initialized
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartData = cartProvider.cart;

    productsFuture = Future.wait(
      cartData.entries.map((entry) async {
        final product = await DatabaseService().singleProduct(entry.key);
        return MapEntry(product, entry.value);
      }),
    );

    _addressController.text = _address;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      backgroundColor: Colors.grey[200],
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
          itemCount = products.length;

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              // Address Section
              Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping Address',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your address',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Payment Section
              Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount (${itemCount} item${itemCount > 1 ? 's' : ''}): ₹${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Payment Method',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      ListTile(
                        title: const Text('Cash on Delivery'),
                        leading: Radio<String>(
                          value: 'Cash on Delivery',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Image.asset('assets/payment/phonepe.png', width: 30, height: 30),
                            const SizedBox(width: 8),
                            const Text('PhonePe'),
                          ],
                        ),
                        leading: Radio<String>(
                          value: 'PhonePe',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Image.asset('assets/payment/googlePay.png', width: 30, height: 30),
                            const SizedBox(width: 8),
                            const Text('Google Pay'),
                          ],
                        ),
                        leading: Radio<String>(
                          value: 'Google Pay',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Image.asset('assets/payment/paytm.png', width: 30, height: 30),
                            const SizedBox(width: 8),
                            const Text('Paytm'),
                          ],
                        ),
                        leading: Radio<String>(
                          value: 'Paytm',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                      ),

                      // Proceed to checkout button
                      ElevatedButton(
                        onPressed: () {
                          // Add your checkout logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Cart Items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final productEntry = products[index];
                  final product = productEntry.key;
                  final quantity = productEntry.value;

                  return CartTile(product: product, quantity: quantity);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
