import 'package:flutter/material.dart';

class task9 extends StatelessWidget {
  const task9({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Column'), backgroundColor: Colors.green),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.yellow),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.red),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.orange),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.amber),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.blue),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.blue),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.yellow),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.red),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.orange),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.amber),
                SizedBox(height: 20),
                Container(height: 400, width: 300, color: Colors.blue),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
