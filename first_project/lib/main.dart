import 'package:first_project/welcome_to_whatsapp2.dart';
import 'package:first_project/welcometowhatsapp.dart';
import 'package:flutter/material.dart';

import 'P001_text.dart';
import 'P003_row_col.dart';
import 'P004_image.dart';
import 'P005_listview.dart';
import 'P006_listtile.dart';
import 'P007_decoration.dart';
import 'P008_card.dart';
import 'P009_stack.dart';
import 'P010_textclick.dart';
import 'P011_datetime.dart';
import 'P012_splashscreen.dart';
import 'P014_bottomnavigation.dart';
import 'P015_navigation_drawer.dart';
import 'P017_Form.dart';
import 'facebook_loginpage.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationDrawer(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('MyApp'),
      //     backgroundColor: Colors.blue.shade800,
      //   ),
      //   body: Text(
      //       'Hello Flutter developers dfb',
      //       style: TextStyle(
      //         fontSize: 30,
      //         color: Colors.white,
      //         backgroundColor: Colors.green,
      //         fontWeight: FontWeight.bold
      //       ),
      //   ),
      // ),
    );
  }
}