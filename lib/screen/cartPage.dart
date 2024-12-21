import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/cartTile.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _address = 'Universal trade tower FieldAssist';
  final TextEditingController _addressController = TextEditingController();

  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    _addressController.text = _address;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      backgroundColor: Colors.grey[200],
      body: Consumer2<CartProvider, ProductProvider>(
        builder: (context, cartProvider, productProvider, child) {
          if (!productProvider.isData) {
            Logger().i("Fetching products...");
            productProvider.getProducts();
          }

          final cartItems = cartProvider.cart.entries.toList();
          final totalPrice = cartItems.fold<double>(
            0.0,
                (total, entry) {
              final product = productProvider.products.firstWhere(
                    (p) => p.id == entry.key,
                orElse: () => throw Exception("Product not found"),
              );
              return total + (product.price * entry.value);
            },
          );

          final itemCount = cartItems.fold<int>(0, (sum, entry) => sum + entry.value);

          return Column(
            children: [
              Expanded(
                child: ListView(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                              'Total Amount ($itemCount item${itemCount > 1 ? 's' : ''}): ₹${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Payment Method',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                                  Image.asset('assets/payment/phonepe.png',
                                      width: 30, height: 30),
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
                                  Image.asset('assets/payment/googlePay.png',
                                      width: 30, height: 30),
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
                                  Image.asset('assets/payment/paytm.png',
                                      width: 30, height: 30),
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
                          ],
                        ),
                      ),
                    ),

                    // Cart Items
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final entry = cartItems[index];
                        final productId = entry.key;
                        final quantity = entry.value;
                        final product = productProvider.products.firstWhere(
                              (p) => p.id == productId,
                          orElse: () => throw Exception("Product not found"),
                        );

                        return CartTile(product: product, quantity: quantity);
                      },
                    ),
                  ],
                ),
              ),

              // Checkout Button
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Checkout logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
