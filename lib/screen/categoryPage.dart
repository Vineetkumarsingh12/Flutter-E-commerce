import 'package:ecommerce/screen/Product_list.dart';
import 'package:flutter/material.dart';

class categoryPage extends StatelessWidget {
  final endpoint, title;
  const categoryPage ({super.key,required this.endpoint, required this.title});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text('$title'),),
      body: SingleChildScrollView(
        child: ProductPage(category: endpoint,)
      )
    );
  }
}
