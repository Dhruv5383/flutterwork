import 'package:flutter/material.dart';

class MyRowColumn extends StatelessWidget {
  const MyRowColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Row Column', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),

        leading: Icon(Icons.insert_emoticon_outlined, color: Colors.white,),
      ),
      body:
      Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.red, height: 20, width: 10,
                    child: Text('1'),
                  ),
                  Container(color: Colors.red, height: 5, width: 10,
                    child: Text('3'),
                  ),
                  Container(color: Colors.red, height: 10, width: 10,
                    child: Text('5'),
                  ),
                  Container(color: Colors.red, height: 5, width: 10,
                    child: Text('7'),
                  ),
                ],
              ),
              // SizedBox(width: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.red, height: 20, width: 35,
                    child: Text('1'),
                  ),
                  Container(color: Colors.red, height: 5, width: 35,
                    child: Text('3'),
                  ),
                  Container(color: Colors.red, height: 10, width: 35,
                    child: Text('5'),
                  ),
                  Container(color: Colors.red, height: 5, width: 35,
                    child: Text('7'),
                  ),
                ],
              ),
              // SizedBox(width: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.red, height: 20, width: 30,
                    child: Text('1'),
                  ),
                  Container(color: Colors.red, height: 5, width: 30,
                    child: Text('3'),
                  ),
                  Container(color: Colors.red, height: 10, width: 30,
                    child: Text('5'),
                  ),
                  Container(color: Colors.red, height: 5, width: 30,
                    child: Text('7'),
                  ),
                ],
              ),
              // SizedBox(width: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.red, height: 20, width: 10,
                    child: Text('1'),
                  ),
                  Container(color: Colors.red, height: 5, width: 10,
                    child: Text('3'),
                  ),
                  Container(color: Colors.red, height: 10, width: 10,
                    child: Text('5'),
                  ),
                  Container(color: Colors.red, height: 5, width: 10,
                    child: Text('7'),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
