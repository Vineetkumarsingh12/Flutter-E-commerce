import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../data/model/product.dart';
import '../screen/Product_details.dart';
import 'cartIncrementDecrement.dart';

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

  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(
     title: widget.product.title,
    image:widget.product.image ,
    rating:widget.product.rating ,
    description: widget.product.description ,
    id: widget.product.id ,
    isLiked: true,
    price: widget.product.price,
  )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            ListTile(
              leading: Image.network(
                widget.product.image,
                fit: BoxFit.contain,
              ),
          title: Text(
            widget.product.title,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
              subtitle: Text('₹ ${(widget.product.price).toStringAsFixed(2)}'),
              trailing: CartIncrementDecrement(
                id: widget.product.id, price: widget.product.price
              ),
            ),
          ],
        ),
      ),
    );
  }
}
