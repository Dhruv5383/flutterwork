import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Q1 auth_provider.dart';
//import 'auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width > 600 ? 400 : width * 0.9,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 15,
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    isLogin ? "Welcome Back" : "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),

                  /// Email
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Enter email";
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  /// Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6)
                        return "Minimum 6 characters";
                      return null;
                    },
                  ),

                  SizedBox(height: 30),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: auth.isLoading
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          String? error;
                          if (isLogin) {
                            error = await auth.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          } else {
                            error = await auth.signup(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          }

                          if (error != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(content: Text(error)),
                            );
                          }
                        }
                      },
                      child: auth.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(isLogin ? "Login" : "Signup"),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// Toggle
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}