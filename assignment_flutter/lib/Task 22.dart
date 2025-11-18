import 'dart:async';

import 'package:flutter/material.dart';

import 'Task 22_2.dart';


class SplashScreeen1 extends StatefulWidget {
  const SplashScreeen1({super.key});

  @override
  State<SplashScreeen1> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen1> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'SplashScreen',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}