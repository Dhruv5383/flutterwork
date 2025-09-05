import 'package:flutter/material.dart';

class task7_listview extends StatelessWidget {
  const task7_listview({super.key});

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
      appBar: AppBar(title: Text("Task 7"),backgroundColor: Colors.brown),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.separated(itemBuilder: (context, index) {
          return Image.asset('assets/images/${images[index]}');
        }, separatorBuilder: (context,index){
          return Divider(
            height: 6,
            thickness: 3.5,);
        },  itemCount: images.length
        ),
      ),
    );
  }
}
