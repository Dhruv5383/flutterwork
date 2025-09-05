import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mycard"),backgroundColor: Colors.blue),
      body: Card(
          color: Colors.green,
          elevation: 16,
          child: Text("Hello flutter design ",style: TextStyle(fontSize: 25)
      ),
    ),
    );
  }
}
