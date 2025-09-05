import 'package:flutter/material.dart';

class MyListview2 extends StatelessWidget {
  const MyListview2({super.key});

  @override
  Widget build(BuildContext context) {

    var images =[
      'car.jpeg',
      'flower.jpeg',
      'laptop.jpeg',
      'phone.jpeg',
      'shoes.jpeg',
      'table.jpeg'
    ];


    return Scaffold(
      appBar: AppBar(title: Text('ListView2'), backgroundColor: Colors.grey),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(itemBuilder: (context, index) {
          return Image.asset('assets/images/${images[index]}');
        },
          itemCount: images.length,
          //scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}