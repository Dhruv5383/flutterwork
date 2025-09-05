import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTime_6 extends StatelessWidget {
  const MyDateTime_6({super.key});

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
                Text('DateTime : ${dateTime}', style: TextStyle(fontSize: 30)),
                Text('Day : ${dateTime.day}', style: TextStyle(fontSize: 30)),
                Text(
                  'Month : ${dateTime.month}',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'DateTime : ${dateTime.hour} : ${dateTime.minute}',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'Formatted : ${DateFormat('jms').format(dateTime)}',
                  style: TextStyle(fontSize: 30),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}