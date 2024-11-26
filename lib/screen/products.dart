import 'package:flutter/material.dart';

import 'Product_list.dart';

class products extends StatelessWidget {
  const products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"),),
      body: SingleChildScrollView(child: ProductPage(endpoint: "/products")),
    );
  }
}
