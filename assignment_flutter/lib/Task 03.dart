import 'package:flutter/material.dart';

class TextStyleApp3 extends StatelessWidget {
  const TextStyleApp3 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, Flutter!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20), // space between texts
              Text(
                'Welcome to Text Styling!',
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrange,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
