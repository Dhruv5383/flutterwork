import 'package:first_project/pages/account.dart';
import 'package:first_project/pages/chat.dart';
import 'package:first_project/pages/home.dart';
import 'package:first_project/pages/settings.dart';
import 'package:first_project/pages/updates.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _bottomNavigation(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    updates(),
    Home(),
    Account(),
    Chat(),
    Setting()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar'),
        backgroundColor: Colors.green,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        // showSelectedLabels: false,
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _bottomNavigation,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'call'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.wechat_sharp), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),


        ],
      ),
    );
  }
}