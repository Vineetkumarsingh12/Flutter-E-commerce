import 'package:flutter/material.dart';

class customDrawer extends StatelessWidget {
  const customDrawer({super.key});

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
                color: Colors.purple[500],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    // borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      'assets/images/company_logo.png',
                      fit: BoxFit.contain,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.black,size: 30,),
                      SizedBox(width: 8),
                      Text(
                        "Vineet Singh",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "75555555555",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "vineet@gmail.com",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.red),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.green),
            title: Text('Products'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.support_agent, color: Colors.green),
            title: Text('Support'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
