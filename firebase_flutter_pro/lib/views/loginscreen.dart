import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_pro/views/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'forgotpasswordscreen.dart';
import 'homescreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              alignment: Alignment.center,
              child: Lottie.asset("assets/s1.json"),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  suffixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  //suffixIcon: Icon(Icon.email),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();
                  try {
                    final User? firebaseUser =
                        (await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        )).user;

                    if (firebaseUser != null) {
                      Get.to(() => Homescreen());
                    } else {
                      print('email or pass is incorrect');
                    }
                  } on FirebaseAuthException catch (e) {
                    print('error msg : $e');
                  }
                },
                child: Text(
                  'Login',
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
                Get.to(() => ForgotPasswordScreen());
              },
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Forgot Password ? '),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Signupscreen()));
              },
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("don`t have a account? Signup"),
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
