import 'package:flutter/material.dart';

import 'Q2 navigation drawer.dart';

/* ---------------- PROFILE SCREEN ---------------- */

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen")),
      drawer: AppDrawer(context),
      body: Center(
        child: Text(
          "This is Profile Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}