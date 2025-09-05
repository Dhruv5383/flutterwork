import 'package:flutter/material.dart';

class Listview extends StatelessWidget {
  const Listview({super.key});

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
      appBar: AppBar(title: Text('ListView'), backgroundColor: Colors.grey),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.separated(itemBuilder: (context, index) {
          return Image.asset('assets/images/${images[index]}');
        }, separatorBuilder: (context, index) {
          return Divider(
            height: 5,
            thickness: 2,
          );
        }, itemCount: images.length),

      ),
    );
  }
}