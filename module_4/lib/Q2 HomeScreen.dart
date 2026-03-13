import 'package:flutter/material.dart';

import 'Q2 navigation drawer.dart';

/* ---------------- HOME SCREEN ---------------- */

class homeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      drawer: AppDrawer(context),
      body: Center(
        child: Text(
          "This is Home Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}