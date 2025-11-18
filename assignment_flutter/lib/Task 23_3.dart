import 'package:flutter/material.dart';

import 'Task 23.dart';

// ---------------- PROFILE SCREEN ----------------
class ProfileScreen23_3 extends StatelessWidget {
  const ProfileScreen23_3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AppDrawer()),
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text("This is Profile Screen", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
