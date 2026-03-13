import 'package:flutter/material.dart';


class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String selectedCategory = 'App Design';
  String comments = '';

  bool serviceQuality = false;
  bool appPerformance = false;
  bool customerSupport = false;

  List<String> categories = [
    'App Design',
    'Features',
    'Performance',
    'Customer Support'
  ];

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String selectedIssues = '';
      if (serviceQuality) selectedIssues += 'Service Quality, ';
      if (appPerformance) selectedIssues += 'App Performance, ';
      if (customerSupport) selectedIssues += 'Customer Support, ';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Feedback Submitted"),
          content: Text(
              "Name: $name\nEmail: $email\nCategory: $selectedCategory\nIssues: $selectedIssues\nComments: $comments"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Please enter your name" : null,
                onSaved: (value) => name = value!,
              ),

              SizedBox(height: 15),

              /// Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.contains("@") ? null : "Enter valid email",
                onSaved: (value) => email = value!,
              ),

              SizedBox(height: 15),

              /// Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  labelText: "Feedback Category",
                  border: OutlineInputBorder(),
                ),
                items: categories
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),

              SizedBox(height: 20),

              /// Checkboxes
              Text("What would you like to improve?",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              CheckboxListTile(
                title: Text("Service Quality"),
                value: serviceQuality,
                onChanged: (value) {
                  setState(() {
                    serviceQuality = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: Text("App Performance"),
                value: appPerformance,
                onChanged: (value) {
                  setState(() {
                    appPerformance = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: Text("Customer Support"),
                value: customerSupport,
                onChanged: (value) {
                  setState(() {
                    customerSupport = value!;
                  });
                },
              ),

              SizedBox(height: 15),

              /// Comments Field
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Additional Comments",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => comments = value ?? '',
              ),

              SizedBox(height: 25),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text("Submit Feedback"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}