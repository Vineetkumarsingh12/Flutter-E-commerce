import 'package:ecommerce/providers/auth.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/screen/layout.dart';
import 'package:ecommerce/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create:(context)=>CartProvider(),
        ),

        ChangeNotifierProvider(
          create:(context)=>AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splashh(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
