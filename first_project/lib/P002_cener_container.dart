import 'package:flutter/material.dart';

class Mytext extends StatelessWidget {
  const Mytext({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Myapp"), backgroundColor: Colors.green,),
      body: Container(
        color: Colors.blue,
        height: 200,
        width: 200,
        child: Text('dhruv hello flutter',style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
