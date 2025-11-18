import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../services/signupService.dart';
import 'loginscreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User? CurrentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('signUp', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              alignment: Alignment.center,
              child: LottieBuilder.asset('assets/s2.json'),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: contactController,
                decoration: InputDecoration(
                  hintText: 'Enter contact',
                  prefixIcon: Icon(Icons.phone),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  var name = nameController.text.trim();
                  var contact = contactController.text.trim();
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();

                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                      .then(
                        (value) => {
                      log(1 as String),
                      signUpUser(name, contact, email, password),
                    },
                  );
                },
                child: Text(
                  ''
                      'signUp',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => Loginscreen());
              },
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("already have an account? Login"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
