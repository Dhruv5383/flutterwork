import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsAppOtpScreen(),
  ));
}

class WhatsAppOtpScreen extends StatefulWidget {
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
            //Icon(Icons.whatsapp, color: Colors.green, size: 80),

            SizedBox(height: 20),

            // Welcome text
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Subtitle
            Text(
              "Enter SMS code",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 20),

            // OTP display (simple style)
            Text(
              smsCode.padRight(4, "_").split("").join("  "),
              style: TextStyle(fontSize: 28, letterSpacing: 8),
            ),

            SizedBox(height: 20),

            // Done button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
              ),
              onPressed: smsCode.length == 4
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Code entered: $smsCode"),
                ));
              }
                  : null,
              child: Text("Done", style: TextStyle(fontSize: 18)),
            ),

            SizedBox(height: 30),

            // Number pad
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.4),
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      return buildNumberButton((index + 1).toString());
                    } else if (index == 9) {
                      return SizedBox.shrink();
                    } else if (index == 10) {
                      return buildNumberButton("0");
                    } else {
                      return IconButton(
                        icon: Icon(Icons.backspace),
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
