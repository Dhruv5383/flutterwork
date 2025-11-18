// import 'package:flutter/material.dart';
//
// class FeedbackFormApp extends StatefulWidget {
//   const FeedbackFormApp({super.key});
//
//   @override
//   State<FeedbackFormApp> createState() => _FeedbackFormAppState();
// }
//
// class _FeedbackFormAppState extends State<FeedbackFormApp> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();
//
//   String? selectedCategory;
//   final List<String> categories = [
//     'App Experience',
//     'Design & UI',
//     'Performance',
//     'Bug Report',
//     'Other'
//   ];
//
//   String message = "";
//
//   void submitFeedback() {
//     if (nameController.text.isEmpty ||
//         commentController.text.isEmpty ||
//         selectedCategory == null) {
//       setState(() {
//         message = "⚠️ Please fill out all fields!";
//       });
//     } else {
//       setState(() {
//         message =
//         "✅ Thank you, ${nameController.text}! Feedback on '$selectedCategory' submitted successfully!";
//         nameController.clear();
//         commentController.clear();
//         selectedCategory = null;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Feedback Form"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "We value your feedback!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//
//             // Name Field
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Dropdown
//             InputDecorator(
//               decoration: const InputDecoration(
//                 labelText: "Feedback Category",
//                 border: OutlineInputBorder(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: selectedCategory,
//                   hint: const Text("Select a category"),
//                   isExpanded: true,
//                   items: categories.map((String category) {
//                     return DropdownMenuItem(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCategory = value;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Comment Field
//             TextField(
//               controller: commentController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 labelText: "Comments",
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.comment),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Submit Button
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: submitFeedback,
//                 icon: const Icon(Icons.send),
//                 label: const Text("Submit"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepPurple,
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Message
//             Center(
//               child: Text(
//                 message,
//                 style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.deepPurple,
//                     fontWeight: FontWeight.w500),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
//
// class FeedbackForm extends StatefulWidget {
//   const FeedbackForm({super.key});
//
//   @override
//   State<FeedbackForm> createState() => _FeedbackFormState();
// }
//
// class _FeedbackFormState extends State<FeedbackForm> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();
//
//   String? selectedCategory;
//   final List<String> categories = [
//     'App Experience',
//     'Design & UI',
//     'Performance',
//     'Bug Report',
//     'Other'
//   ];
//
//   String message = "";
//
//   void submitFeedback() {
//     if (nameController.text.isEmpty ||
//         commentController.text.isEmpty ||
//         selectedCategory == null) {
//       setState(() {
//         message = "⚠️ Please fill all fields!";
//       });
//     } else {
//       setState(() {
//         message =
//         "✅ Thank you, ${nameController.text}! Feedback on '$selectedCategory' submitted!";
//         nameController.clear();
//         commentController.clear();
//         selectedCategory = null;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Feedback Form"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "We value your feedback!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             InputDecorator(
//               decoration: const InputDecoration(
//                 labelText: "Category",
//                 border: OutlineInputBorder(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: selectedCategory,
//                   hint: const Text("Select category"),
//                   isExpanded: true,
//                   items: categories.map((String category) {
//                     return DropdownMenuItem(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCategory = value;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             TextField(
//               controller: commentController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 labelText: "Comments",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             Center(
//               child: ElevatedButton(
//                 onPressed: submitFeedback,
//                 child: const Text("Submit"),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             Center(
//               child: Text(
//                 message,
//                 style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.blue),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(FeedbackFormApp());
// }
//
// class FeedbackFormApp extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();
//
//   final List<String> categories = ['App Experience', 'Bug Report', 'Suggestion', 'Other'];
//   String selectedCategory = 'App Experience';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StatefulBuilder(
//         builder: (context, setState) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Feedback Form'),
//               backgroundColor: Colors.blueAccent,
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Your Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     value: selectedCategory,
//                     decoration: InputDecoration(
//                       labelText: 'Feedback Category',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: categories
//                         .map((cat) => DropdownMenuItem(
//                       value: cat,
//                       child: Text(cat),
//                     ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCategory = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: commentController,
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                       labelText: 'Your Comments',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         String name = nameController.text;
//                         String comment = commentController.text;
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               'Thank you, $name! Your "$selectedCategory" feedback was submitted.',
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text('Submit Feedback'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class FeedbackFormApp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  final List<String> categories = [
    'App Experience',
    'Bug Report',
    'Suggestion',
    'Other'
  ];

  String selectedCategory = 'App Experience';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Feedback Form'),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Feedback Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categories
                      .map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),

                SizedBox(height: 16),

                TextField(
                  controller: commentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Your Comments',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String comment = commentController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Thank you, $name! Your "$selectedCategory" feedback was submitted.',
                          ),
                        ),
                      );
                    },
                    child: Text('Submit Feedback'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
