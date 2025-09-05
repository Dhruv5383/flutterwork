import 'package:flutter/material.dart';

class MyLayoutApp3 extends StatelessWidget {
  const MyLayoutApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task 3'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Green and Blue+Red Column
              Expanded(
                child: Row(
                  children: [
                    // Green box
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: const Color(0xFF2AA650),
                        margin: const EdgeInsets.only(right: 10),
                      ),
                    ),
                    // Blue on top, Red below
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            color: const Color(0xFF58AAE8),
                            margin: const EdgeInsets.only(bottom: 10),
                          ),
                          Expanded(
                            child: Container(color: const Color(0xFFE74E33)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Bottom Purple Box
              Container(
                height: 150,
                width: double.infinity,
                color: const Color(0xFF8D43B3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
