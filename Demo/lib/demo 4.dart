import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTime_4 extends StatelessWidget {
  const MyDateTime_4({super.key});

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text('Date Time'), backgroundColor: Colors.blue),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2026),
                    );
                    if (date != null) {
                      print(
                        'Date : ${date.day} : ${date.month} : ${date.year}',
                      );
                    }
                  },
                  child: Text('Select date', style: TextStyle(fontSize: 30)),
                ),

                SizedBox(height: 20),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}