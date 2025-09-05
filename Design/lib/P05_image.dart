import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyImage'),
        backgroundColor:Colors.grey,
      ),
      body: Container(
        height: 100,
        width: 100,
        // child: Image.asset('assets/images/itachi.jpg',),

        child: CircleAvatar(backgroundImage: AssetImage('assets/images/itachi.jpg'),),

      ),
    );
  }
}