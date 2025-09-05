import 'package:demo/P011_datetime.dart';
import 'package:demo/demo%203.dart';
import 'package:demo/demo%204.dart';
import 'package:demo/demo%205.dart';
import 'package:demo/demo%206.dart';
import 'package:demo/demo%207.dart';
import 'package:flutter/material.dart';

import 'Instagram.dart';
import 'WhatsAppHome.dart';
import 'WhatsAppSettings.dart';
import 'demo.dart';
import 'demo2.dart';

void main() {
  runApp(const mytext());
}

class mytext extends StatelessWidget {
  const mytext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: WhatsAppWelcome());
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

