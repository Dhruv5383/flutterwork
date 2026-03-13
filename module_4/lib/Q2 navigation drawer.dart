import 'package:flutter/material.dart';

import 'Q2 HomeScreen.dart';
import 'Q2 ProductScreen.dart';
import 'Q2 ProfileScreen.dart';


/* ---------------- DRAWER WIDGET ---------------- */

class AppDrawer extends StatelessWidget {
  final BuildContext parentContext;

  AppDrawer(this.parentContext);

  void navigateTo(Widget screen) {
    Navigator.pop(parentContext); // close drawer
    Navigator.push(
      parentContext,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35),
                ),
                SizedBox(height: 10),
                Text("Welcome User",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () => navigateTo(homeScreen()),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Products"),
            onTap: () => navigateTo(ProductScreen()),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () => navigateTo(ProfileScreen()),
          ),
        ],
      ),
    );
  }
}


