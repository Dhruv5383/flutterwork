import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Task 40_2 Auth Provider (Global State).dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthProvider>().login();
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
