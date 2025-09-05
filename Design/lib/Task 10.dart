import 'package:flutter/material.dart';

class task10 extends StatelessWidget {
  const task10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyApp'), backgroundColor: Colors.green),
      body: Container(
        color: Colors.tealAccent,
        height: 200,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, color: Colors.blue),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.red),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.yellow),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.greenAccent),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.blue),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.red),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.yellow),
              SizedBox(width: 10),
              Container(height: 100, width: 100, color: Colors.greenAccent),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
