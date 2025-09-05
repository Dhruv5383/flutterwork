import 'package:flutter/material.dart';

class List_view_1 extends StatelessWidget {
  const List_view_1({super.key});

  @override
  Widget build(BuildContext context) {

    var names =[
      'Dhruv','Kush','Vishva','Het','Nikhil','Prachi','Archi','Vasu',
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Task 5"),backgroundColor: Colors.grey),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.separated(
            itemCount: names.length,
            itemBuilder: (context, index)
            { return ListTile(title: Text(names[index]),
            );
            }, separatorBuilder:  (context, index) => Divider(
            height: 3,
            thickness: 2,
            color: Colors.grey, // optional: set color
          ),
          )
      ),
    );
  }
}
