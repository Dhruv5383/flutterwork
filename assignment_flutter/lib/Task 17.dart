// // import 'package:flutter/material.dart';
// //
// // class RegistrationFormApp extends StatefulWidget {
// //   const RegistrationFormApp({super.key});
// //
// //   @override
// //   State<RegistrationFormApp> createState() => _RegistrationFormAppState();
// // }
// //
// // class _RegistrationFormAppState extends State<RegistrationFormApp> {
// //   final _formKey = GlobalKey<FormState>();
// //
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final TextEditingController _phoneController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Registration Form"),
// //           backgroundColor: Colors.teal,
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Form(
// //             key: _formKey,
// //             child: ListView(
// //               children: [
// //                 TextFormField(
// //                   controller: _nameController,
// //                   decoration: const InputDecoration(
// //                     labelText: "Name",
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return "Please enter your name";
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 const SizedBox(height: 16),
// //
// //                 TextFormField(
// //                   controller: _emailController,
// //                   keyboardType: TextInputType.emailAddress,
// //                   decoration: const InputDecoration(
// //                     labelText: "Email",
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return "Please enter your email";
// //                     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// //                       return "Enter a valid email address";
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 const SizedBox(height: 16),
// //
// //                 TextFormField(
// //                   controller: _passwordController,
// //                   obscureText: true,
// //                   decoration: const InputDecoration(
// //                     labelText: "Password",
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return "Please enter your password";
// //                     } else if (value.length < 6) {
// //                       return "Password must be at least 6 characters";
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 const SizedBox(height: 16),
// //
// //                 TextFormField(
// //                   controller: _phoneController,
// //                   keyboardType: TextInputType.phone,
// //                   decoration: const InputDecoration(
// //                     labelText: "Phone Number",
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return "Please enter your phone number";
// //                     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
// //                       return "Enter a valid 10-digit phone number";
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 const SizedBox(height: 24),
// //
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.teal,
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                   ),
// //                   onPressed: () {
// //                     if (_formKey.currentState!.validate()) {
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         const SnackBar(
// //                             content: Text("Registration Successful!")),
// //                       );
// //                     }
// //                   },
// //                   child: const Text(
// //                     "Register",
// //                     style: TextStyle(fontSize: 18, color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
//
// class RegistrationFormApp extends StatefulWidget {
//   const RegistrationFormApp({super.key});
//
//   @override
//   State<RegistrationFormApp> createState() => _RegistrationFormAppState();
// }
//
// class _RegistrationFormAppState extends State<RegistrationFormApp> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Builder(
//         builder: (context) => Scaffold(
//           appBar: AppBar(
//             title: const Text("Registration Form"),
//             backgroundColor: Colors.teal,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: "Name",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your name";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your email";
//                       } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                           .hasMatch(value)) {
//                         return "Enter a valid email address";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your password";
//                       } else if (value.length < 6) {
//                         return "Password must be at least 6 characters";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//
//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: const InputDecoration(
//                       labelText: "Phone Number",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your phone number";
//                       } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                         return "Enter a valid 10-digit phone number";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24),
//
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Scaffold(
//                               appBar: AppBar(
//                                 title: const Text("Registration Details"),
//                                 backgroundColor: Colors.teal,
//                               ),
//                               body: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Name: ${_nameController.text}",
//                                       style: const TextStyle(fontSize: 18),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       "Email: ${_emailController.text}",
//                                       style: const TextStyle(fontSize: 18),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       "Password: ${_passwordController.text}",
//                                       style: const TextStyle(fontSize: 18),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       "Phone: ${_phoneController.text}",
//                                       style: const TextStyle(fontSize: 18),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//
// import 'package:flutter/material.dart';
// import 'Task 17_2.dart'; // Import the second page file
//
// void main() => runApp(const RegistrationFormApp());
//
// class RegistrationFormApp extends StatefulWidget {
//   const RegistrationFormApp({super.key});
//
//   @override
//   State<RegistrationFormApp> createState() => _RegistrationFormAppState();
// }
//
// class _RegistrationFormAppState extends State<RegistrationFormApp> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Registration Form"),
//           backgroundColor: Colors.teal,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                     labelText: "Name",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your name";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your email";
//                     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                         .hasMatch(value)) {
//                       return "Enter a valid email address";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: "Password",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your password";
//                     } else if (value.length < 6) {
//                       return "Password must be at least 6 characters";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 TextFormField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     labelText: "Phone Number",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your phone number";
//                     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return "Enter a valid 10-digit phone number";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),
//
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegistrationDetailsPage(
//                             name: _nameController.text,
//                             email: _emailController.text,
//                             password: _passwordController.text,
//                             phone: _phoneController.text,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// only for scaffold

import 'package:flutter/material.dart';
import 'Task 17_2.dart'; // Import the second page file

void main() => runApp(const RegistrationFormApp());

class RegistrationFormApp extends StatefulWidget {
  const RegistrationFormApp({super.key});

  @override
  State<RegistrationFormApp> createState() => _RegistrationFormAppState();
}

class _RegistrationFormAppState extends State<RegistrationFormApp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality( // Needed when not using MaterialApp
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registration Form"),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegistrationDetailsPage(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
