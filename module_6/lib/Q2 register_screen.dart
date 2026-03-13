import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../providers/auth_provider.dart';
import 'Q1 auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  String? strongPasswordValidator(String value) {
    if (value.length < 8) {
      return "Minimum 8 characters required";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Must contain special character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff667eea), Color(0xff764ba2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: width > 600 ? 500 : double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    const Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),

                    buildTextField(nameController, "Full Name"),
                    const SizedBox(height: 15),

                    buildTextField(emailController, "Email",
                        keyboard: TextInputType.emailAddress),
                    const SizedBox(height: 15),

                    buildTextField(phoneController, "Phone",
                        keyboard: TextInputType.phone),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12)),
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
                      validator: (value) =>
                          strongPasswordValidator(value ?? ""),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12)),
                        ),
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!
                              .validate()) {
                            final error =
                            await auth.register(
                                emailController.text
                                    .trim(),
                                passwordController.text
                                    .trim());

                            if (error != null) {
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                SnackBar(
                                    content:
                                    Text(error)),
                              );
                            } else {
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Registration Successful")),
                              );
                            }
                          }
                        },
                        child: auth.isLoading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller,
      String label,
      {TextInputType keyboard =
          TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) =>
      value == null || value.isEmpty
          ? "Required field"
          : null,
    );
  }
}