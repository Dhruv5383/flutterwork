import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homeScreen.dart';

class EditeNoteScreen extends StatefulWidget {
  const EditeNoteScreen({super.key});

  @override
  State<EditeNoteScreen> createState() => _EditeNoteScreenState();
}

class _EditeNoteScreenState extends State<EditeNoteScreen> {
  TextEditingController noteEditeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note'), backgroundColor: Colors.blue),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller:
                noteEditeController
                  ..text = "${Get.arguments['note'].toString()}",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('notes')
                    .doc(Get.arguments['docId'].toString())
                    .update({'note': noteEditeController.text.trim()})
                    .then((value) {
                  Get.offAll(() => Homescreen());
                  print('note updated');
                });
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}