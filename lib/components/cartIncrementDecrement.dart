import 'package:ecommerce/components/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartIncrementDecrement extends StatefulWidget {
  CartIncrementDecrement({super.key, required this.id});

  final int id;

  @override
  _CartIncrementDecrementState createState() => _CartIncrementDecrementState();
}

class _CartIncrementDecrementState extends State<CartIncrementDecrement> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  int previousValidCount = 0;
  static const int maxCount = 10000; // Maximum count

  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    previousValidCount = cartProvider.cart[widget.id] ?? 0;
    _controller = TextEditingController(text: previousValidCount.toString());
    _focusNode = FocusNode();

    // FocusNode listener to detect when the keyboard is closed
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _onKeyboardClosed();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onKeyboardClosed() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final newCount = int.tryParse(_controller.text);

    // If the entered value is invalid or exceeds limits
    if (newCount == null || newCount < 0) {
      showSnackBar(
          context, 'Invalid value! Resetting to previous valid count.');
      _controller.text = previousValidCount.toString();
    } else if (newCount > maxCount) {
      showSnackBar(
          context, 'Value too large! Enter a value less than $maxCount.');
      _controller.text = previousValidCount.toString();
    } else {
      // If the value is valid, update the cart and save the new valid count
      cartProvider.updateCart(id: widget.id, count: newCount);
      previousValidCount = newCount;
    }
  }


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartCount = cartProvider.cart[widget.id] ?? 0;

    // Update the controller text when cart count changes
    if (_controller.text != cartCount.toString()) {
      _controller.text = cartCount.toString();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: cartCount == 0
          ? ElevatedButton(
        onPressed: () {
          cartProvider.addToCart(id: widget.id);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,

          // White text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                12.0),
          ),
        ),
        child: Text("Add to Cart"),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Decrease Button
          SizedBox(
            width: 30,
            height: 40,
            child: IconButton(
              onPressed: () {
                cartProvider.removeFromCart(id: widget.id);
              },
              icon: const Icon(Icons.remove, color: Colors.black),
              splashRadius: 15,
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          // Divider
          Container(
            height: 24.0,
            width: 1,
            color: Colors.grey.shade300,
          ),
          // Editable Count with TextField
          SizedBox(
            width: 40,
            height: 21,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              // Attach the focus node
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              onChanged: (value) {
                // Try to parse the value and update cart count if valid
                int? newCount = int.tryParse(value);
                if (newCount != null && newCount >= 0 && newCount <= maxCount) {
                  cartProvider.updateCart(id: widget.id, count: newCount);
                  previousValidCount = newCount;
                } else if (newCount != null && newCount > maxCount) {
                  showSnackBar(
                      context, 'Value too large! Maximum is $maxCount.');
                  _controller.text = previousValidCount.toString();
                }
              },
              onSubmitted: (value) {
                _onKeyboardClosed(); // Handle logic when "Enter" is pressed
              },
            ),
          ),
          // Divider
          Container(
            height: 24.0,
            width: 1,
            color: Colors.grey.shade300,
          ),
          // Increase Button
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                if (cartCount < maxCount) {
                  cartProvider.addToCart(id: widget.id);
                } else {
                  showSnackBar(
                      context, 'Cannot exceed maximum count of $maxCount.');
                }
              },
              icon: const Icon(Icons.add, color: Colors.black),
              splashRadius: 15,
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
