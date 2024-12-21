import 'package:ecommerce/components/webView.dart';
import 'package:ecommerce/screen/authentication/login.dart';
import 'package:ecommerce/screen/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../screen/profilePage.dart';

class customDrawer extends StatelessWidget {
  const customDrawer({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.logout();
      final cartProvider=await Provider.of<CartProvider>(context, listen: false);
      cartProvider.cart={};


      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error logging out')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 400,
            child: DrawerHeader(
              decoration: BoxDecoration(
                // Gradient that matches the app's color scheme
                gradient: LinearGradient(
                  colors: [Colors.purple[400]!, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    // borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/company_logo.png',
                      fit: BoxFit.contain,
                      height: 150, // Adjusted size to fit better in header
                      width: 150,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.white, size: 30),
                      SizedBox(width: 8),
                      Text(
                        "Vineet Singh",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0, // Adjusted font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "75555555555",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "vineet@gmail.com",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.purple),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Navigate to the Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.pink),
            title: Text(
              'Products',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Navigate to the Products Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => products()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent, color: Colors.purple),
            title: Text(
              'Support',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Open the Custom WebView with a URL
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomWebView(
                    url: "https://en.wikipedia.org/wiki/E-commerce_in_India",
                  ),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){
              print("##########");
              _logout(context);
            }

          ),
        ],
      ),
    );
  }
}
