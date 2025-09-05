import 'package:flutter/material.dart';

class margin_padding extends StatelessWidget {
  const margin_padding({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Margin Paddging'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.all(50),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 100, 50),
          child: Text(
            'Hello dhruv ',
            style: TextStyle(
              fontSize: 15,
              backgroundColor: Colors.grey,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}