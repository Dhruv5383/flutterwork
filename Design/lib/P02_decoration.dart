import 'package:flutter/material.dart';

class MyDecoration extends StatelessWidget {
  const MyDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("P02_Decoration"),backgroundColor: Colors.greenAccent),
      body: Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black,width: 1.8),
            boxShadow: [BoxShadow(color: Colors.black,blurRadius: 15,spreadRadius: 10
            )]
          ),
        ),
      ),

    );
  }
}
