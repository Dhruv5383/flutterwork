import 'package:design/P02_decoration.dart';
import 'package:design/P02_decoration.dart';
import 'package:design/P03_Card.dart';
import 'package:design/Task%2010.dart';
import 'package:design/row_column.dart';
import 'package:design/Task 7_listview2.dart';
import 'package:flutter/material.dart';

import 'P04_Margin_Padding.dart';
import 'P05_image.dart';
import 'P06_listview1.dart';
import 'P07_listview2.dart';
import 'P08_listtile.dart';
import 'P09_stack1.dart';
import 'P10_stack2.dart';
import 'Task 6_listview.dart';
import 'Task 8_listtie.dart';
import 'Task 9.dart';

void main() {
  runApp(const mytext());
}

class mytext extends StatelessWidget {
  const mytext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Mystack_2());
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App', style: TextStyle(fontSize: 25,
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        height: 100,
        color: Colors.blue,
        child: Center(
          child: Text(
            'Hello Flutter developers',
            //'Dhruv m Patel '
            style: TextStyle(fontSize: 20, color: Colors.blue.shade500,backgroundColor: Colors.amber),
          ),
        ),
      ),
    );
  }
}

