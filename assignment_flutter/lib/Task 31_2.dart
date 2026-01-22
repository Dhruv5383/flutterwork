import 'package:flutter/material.dart';


/// 🚀 HERO DETAIL PAGE
class HeroDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Detail")),
      body: Center(
        child: Hero(
          tag: "hero-card",
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(24),
            ),
            alignment: Alignment.center,
            child: Text(
              "Hero Page",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
