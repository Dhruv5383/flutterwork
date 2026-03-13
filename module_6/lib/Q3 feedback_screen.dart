import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../model/feedback_model.dart';
//import '../provider/feedback_provider.dart';
import 'Q3 feedback_model.dart';
import 'Q3 feedback_provider.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String category = 'App Design';
  String comments = '';
  List<String> improvements = [];

  final categories = ['App Design', 'Features', 'Performance', 'Support'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [

                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) =>
                    value!.isEmpty ? "Enter name" : null,
                    onSaved: (value) => name = value!,
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
                    onSaved: (value) => email = value!,
                  ),

                  SizedBox(height: 16),

                  DropdownButtonFormField(
                    value: category,
                    items: categories
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                        .toList(),
                    onChanged: (val) => category = val!,
                    decoration:
                    InputDecoration(labelText: "Category"),
                  ),

                  SizedBox(height: 16),

                  CheckboxListTile(
                    value: improvements.contains("Performance"),
                    title: Text("Performance"),
                    onChanged: (val) {
                      setState(() {
                        val!
                            ? improvements.add("Performance")
                            : improvements.remove("Performance");
                      });
                    },
                  ),

                  CheckboxListTile(
                    value: improvements.contains("Support"),
                    title: Text("Support"),
                    onChanged: (val) {
                      setState(() {
                        val!
                            ? improvements.add("Support")
                            : improvements.remove("Support");
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    maxLines: 3,
                    decoration:
                    InputDecoration(labelText: "Comments"),
                    onSaved: (val) => comments = val ?? '',
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final model = FeedbackModel(
                          name: name,
                          email: email,
                          category: category,
                          improvements: improvements,
                          comments: comments,
                        );

                        bool success =
                        await provider.submit(model);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          content: Text(success
                              ? "Submitted Successfully"
                              : "Submission Failed"),
                        ));
                      }
                    },
                    child: provider.isLoading
                        ? CircularProgressIndicator(
                        color: Colors.white)
                        : Text("Submit"),
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