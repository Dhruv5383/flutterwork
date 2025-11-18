// ---------------- HOME SCREEN ----------------

import 'package:flutter/material.dart';

import 'Task 23.dart';

class HomeScreen23_2 extends StatelessWidget {
  const HomeScreen23_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AppDrawer()),
            );
          },
        ),),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text("This is Home Screen", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
