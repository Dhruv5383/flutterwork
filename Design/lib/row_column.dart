import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyApp'), backgroundColor: Colors.green),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 100, width: 100, color: Colors.blue),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.red),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.yellow,),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.greenAccent),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.blue),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.red),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.yellow,),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, color: Colors.greenAccent),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
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
