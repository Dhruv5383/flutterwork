// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WhatsAppWelcome(),
//   ));
// }
//
// class WhatsAppWelcome extends StatefulWidget {
//   const WhatsAppWelcome({super.key});
//
//   @override
//   State<WhatsAppWelcome> createState() => _WhatsAppWelcomeState();
// }
//
// class _WhatsAppWelcomeState extends State<WhatsAppWelcome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 // WhatsApp Logo
//                 Image.asset('assets/images/whatsapplogo.png'),
//                 // Icon(
//                 //   Icons.add,
//                 //   size: 100,
//                 //   color: Colors.green,
//                 // ),
//
//                 const SizedBox(height: 30),
//
//                 // Welcome Text
//                 const Text(
//                   "Welcome to WhatsApp",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Phone number input with flag
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       // Flag
//                       const Text("🇮🇳", style: TextStyle(fontSize: 24)),
//                       const SizedBox(width: 10),
//
//                       // Country code
//                       const Text(
//                         "+91",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//
//                       const SizedBox(width: 10),
//
//                       // Placeholder dashes
//                       Expanded(
//                         child: Text(
//                           "--- --- -- --",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Send Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     onPressed: () {
//                       // Example of using setState
//                       setState(() {
//                         // Later you can update UI here when needed
//                       });
//                     },
//                     child: const Text(
//                       "Send",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Footer Text
//                 Column(
//                   children: const [
//                     Text.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(text: "Read our "),
//                           TextSpan(
//                             text: "Privacy Policy",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           TextSpan(text: ". Tap “Agree & Continue” to accept the "),
//                           TextSpan(
//                             text: "Terms of Service",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           TextSpan(text: "."),
//                         ],
//                       ),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "from FACEBOOK",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WhatsAppWelcome(),
//   ));
// }
//
// class WhatsAppWelcome extends StatefulWidget {
//   const WhatsAppWelcome({super.key});
//
//   @override
//   State<WhatsAppWelcome> createState() => _WhatsAppWelcomeState();
// }
//
// class _WhatsAppWelcomeState extends State<WhatsAppWelcome> {
//   final TextEditingController phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // WhatsApp Logo
//                 Image.asset('assets/images/whatsapplogo.png'),
//
//                 const SizedBox(height: 30),
//
//                 // Welcome Text
//                 const Text(
//                   "Welcome to WhatsApp",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Phone number input with flag
//                 Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       // Flag
//                       const Text("🇮🇳", style: TextStyle(fontSize: 24)),
//                       const SizedBox(width: 10),
//
//                       // Country code
//                       const Text(
//                         "+91",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//
//                       const SizedBox(width: 10),
//
//                       // Phone number input field
//                       Expanded(
//                         child: TextField(
//                           controller: phoneController,
//                           keyboardType: TextInputType.phone,
//                           maxLength: 10, // Limit to 10 digits
//                           decoration: const InputDecoration(
//                             counterText: "", // Hide length counter
//                             border: InputBorder.none,
//                             hintText: "Enter phone number",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Send Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     onPressed: () {
//                       if (phoneController.text.length == 10) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               "Phone Number: +91 ${phoneController.text}",
//                             ),
//                           ),
//                         );
//                         // Later, navigate to OTP page
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("Enter a valid 10-digit number")),
//                         );
//                       }
//                     },
//                     child: const Text(
//                       "Send",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Footer Text
//                 Column(
//                   children: const [
//                     Text.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(text: "Read our "),
//                           TextSpan(
//                             text: "Privacy Policy",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           TextSpan(
//                               text:
//                               ". Tap “Agree & Continue” to accept the "),
//                           TextSpan(
//                             text: "Terms of Service",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           TextSpan(text: "."),
//                         ],
//                       ),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "from FACEBOOK",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsAppWelcome(),
  ));
}

class WhatsAppWelcome extends StatefulWidget {
  const WhatsAppWelcome({super.key});

  @override
  State<WhatsAppWelcome> createState() => _WhatsAppWelcomeState();
}

class _WhatsAppWelcomeState extends State<WhatsAppWelcome> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // WhatsApp Logo
                Image.asset('assets/images/whatsapplogo.png'),

                const SizedBox(height: 30),

                // Welcome Text
                const Text(
                  "Welcome to WhatsApp",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                // Phone number input with flag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text("🇮🇳", style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      const Text(
                        "+91",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),

                      // Phone number input field
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Enter phone number",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Send Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      if (phoneController.text.length == 10) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WhatsAppOtpScreen(
                              phoneNumber: phoneController.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Enter a valid 10-digit number")),
                        );
                      }
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Footer Text
                Column(
                  children: const [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Read our "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                              text:
                              ". Tap “Agree & Continue” to accept the "),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(text: "."),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "from FACEBOOK",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WhatsAppOtpScreen extends StatefulWidget {
  final String phoneNumber;
  const WhatsAppOtpScreen({super.key, required this.phoneNumber});

  @override
  State<WhatsAppOtpScreen> createState() => _WhatsAppOtpScreenState();
}

class _WhatsAppOtpScreenState extends State<WhatsAppOtpScreen> {
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification"), backgroundColor: Colors.green),
      body: Center(
        child: Text(
          "Enter OTP sent to +91 ${widget.phoneNumber}",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}