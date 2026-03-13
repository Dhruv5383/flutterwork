import 'package:flutter/material.dart';

import 'Q2 navigation drawer.dart';


/* ---------------- PRODUCT SCREEN ---------------- */

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Screen")),
      drawer: AppDrawer(context),
      body: Center(
        child: Text(
          "This is Product Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
