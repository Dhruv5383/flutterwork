import 'package:flutter/material.dart';

class Mylisttile extends StatelessWidget {
  const Mylisttile({super.key});

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
    var name =[
      'car',
      'flower',
      'laptop',
      'phone',
      'shoes',
      'table'
    ];
    var desc =[
      'car',
      'flower',
      'laptop',
      'phone',
      'shoes',
      'table'
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Listtile"),backgroundColor: Colors.green),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.separated(itemBuilder: (context,index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/${images[index]}'),
            ) ,
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('${name[index]}',style: TextStyle(fontSize: 20)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text('${desc[index]}',style: TextStyle(fontSize: 15)),
            ),
            trailing: Icon(Icons.density_medium),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 5, thickness: 2);
          },
          itemCount: images.length,
      ),
    ),
    );
  }
}
