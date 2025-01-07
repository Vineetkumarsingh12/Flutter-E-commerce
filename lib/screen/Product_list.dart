import 'package:ecommerce/screen/productPage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductPage extends StatefulWidget {
  final String? category;

  ProductPage({Key? key, this.category}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    // Initialize the ProductProvider
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    if (!productProvider.isData) {
      Logger().i("Initializing ProductProvider and fetching products...");
      productProvider.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the updated productProvider instance
    productProvider = Provider.of<ProductProvider>(context);
    final productData = widget.category == null
        ? productProvider.products
        : productProvider.products
        .where((product) => product.category == widget.category)
        .toList();

    Logger().i("category  ${widget.category}");

    Logger().i("ProductPage: ${productData.length} products found.");

    return  Ppage(productData:productData);
  }
}
