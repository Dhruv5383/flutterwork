import 'package:flutter/material.dart';

class Mystack_2 extends StatelessWidget {
  const Mystack_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(220, 660, 0, 5),
            child: Text('GREEN',style: TextStyle(fontSize: 15,backgroundColor: Colors.green)),),
        ),
        Container(
          height: 650,
          width: double.infinity,
          //color: Colors.blue,
          decoration: BoxDecoration(color: Colors.tealAccent,borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(215, 625, 0, 5),
            child: Text('TEALACCENT',style: TextStyle(fontSize: 15,backgroundColor: Colors.tealAccent)),),
        ),
        Container(
          height: 550,
          width: double.infinity,
          //color: Colors.blue,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
          child: Text("blue",style: TextStyle(fontSize: 10,backgroundColor: Colors.black),),
        ),
        Container(
          height: 450,
          width: double.infinity,
          //color: Colors.red,
          decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
        ),
        Container(
          height: 350,
          width: double.infinity,
          //color: Colors.red,
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
        ),
        Container(
          height: 250,
          width: double.infinity,
          //color: Colors.yellow,
          decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
        ),
        Container(
          height: 150,
          width: double.infinity,
          //color: Colors.blueGrey,
          decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
        ),
        Container(
          height: 50,
          width: double.infinity,
          //color: Colors.blueGrey,
          decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
        ),
      ],
    );
  }
}
