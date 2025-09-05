import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTime_5 extends StatelessWidget {
  const MyDateTime_5({super.key});

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
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (time != null) {
                      print('Time : ${time.hour} : ${time.minute}');
                    }
                  },
                  child: Text('Select Time', style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}