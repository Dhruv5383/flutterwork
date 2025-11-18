import 'package:flutter/material.dart';

class RegistrationDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String phone;

  const RegistrationDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Details"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Email: $email", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Password: $password", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Phone: $phone", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                Navigator.pop(context); // Go back to the form
              },
              child: const Text("Back", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
