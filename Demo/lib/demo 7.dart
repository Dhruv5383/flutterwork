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

                // Phone number input
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixText: "🇮🇳 +91 ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Enter phone number",
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
                      if (phoneController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WhatsAppOtpScreen(
                                phoneNumber: phoneController.text,
                              )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter your phone number")),
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
                          TextSpan(text: ". Tap “Agree & Continue” to accept the "),
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
  _WhatsAppOtpScreenState createState() => _WhatsAppOtpScreenState();
}

class _WhatsAppOtpScreenState extends State<WhatsAppOtpScreen> {
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WhatsApp logo
            Image.asset('assets/images/whatsapplogo.png'),

            const SizedBox(height: 20),

            // Welcome text
            const Text(
              "Welcome to WhatsApp",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Text(
              "Enter SMS code sent to +91 ${widget.phoneNumber}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            // OTP display
            Text(
              smsCode.padRight(4, "_").split("").join("  "),
              style: const TextStyle(fontSize: 28, letterSpacing: 8),
            ),

            const SizedBox(height: 20),

            // Done button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
              ),
              onPressed: smsCode.length == 4
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Code entered: $smsCode"),
                ));
              }
                  : null,
              child: const Text("Done", style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 30),

            // Number pad
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.4),
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      return buildNumberButton((index + 1).toString());
                    } else if (index == 9) {
                      return const SizedBox.shrink();
                    } else if (index == 10) {
                      return buildNumberButton("0");
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.backspace),
                        onPressed: () {
                          if (smsCode.isNotEmpty) {
                            setState(() {
                              smsCode =
                                  smsCode.substring(0, smsCode.length - 1);
                            });
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumberButton(String number) {
    return InkWell(
      onTap: () {
        if (smsCode.length < 4) {
          setState(() {
            smsCode += number;
          });
        }
      },
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}