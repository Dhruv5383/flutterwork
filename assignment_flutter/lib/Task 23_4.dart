// ---------------- SETTINGS SCREEN ----------------

import 'package:assignment_flutter/Task%2023_2.dart';
import 'package:flutter/material.dart';

import 'Task 23.dart';

class SettingsScreen23_4 extends StatelessWidget {
  const SettingsScreen23_4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AppDrawer()),
          );
        },
        ),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "This is Settings Screen", style: TextStyle(fontSize: 22),),
      ),
    );
  }}
