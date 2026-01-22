// import 'package:flutter/material.dart';
//
// class Task_30_31 extends StatelessWidget {
//   const Task_30_31({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F4F6),
//       appBar: AppBar(
//         title: const Text('Profile Page with FAB'),
//         backgroundColor: const Color(0xFF1F2937),
//         foregroundColor: Colors.white,
//         elevation: 2,
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 220,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF1F2937), Color(0xFF4B5563)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 130),
//               ],
//             ),
//             Positioned(
//               top: 130,
//               left: 0,
//               right: 0,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 24),
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: const [
//                     SizedBox(height: 50),
//                     Text(
//                       'Dhruv Patel',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF111827),
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       'Flutter Developer',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color(0xFF6B7280),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Positioned(
//               top: 70,
//               left: 0,
//               right: 0,
//               child: CircleAvatar(
//                 radius: 55,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/images/dhruv.jpg'),
//                 ),
//               ),
//             ),
//
//             Positioned(
//               top: 310,
//               right: 40,
//               child: FloatingActionButton(
//                 backgroundColor: const Color(0xFF2563EB), // modern blue
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Edit Profile button pressed'),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 },
//                 child: const Icon(Icons.edit, color: Colors.white),
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
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient Background
//           Container(
//             height: 470,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue, Colors.purple],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // Profile Image
//           Positioned(
//             top: 180,
//             left: MediaQuery.of(context).size.width / 2 - 60,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: NetworkImage(
//                 'https://i.pravatar.cc/300',
//               ),
//             ),
//           ),
//
//           // Rounded Card with Details
//           Positioned(
//             top: 260,
//             left: 20,
//             right: 20,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               elevation: 8,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Dhruv Patel',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Flutter Developer\nPassionate about clean UI & performance 🚀',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Constants for styling
  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. THE STACK SECTION
          // We use Stack to layer the profile picture on top of the cover image.
          Stack(
            clipBehavior: Clip.none, // Allows the profile image to hang out of the Stack
            alignment: Alignment.center,
            children: [
              // Layer A: The Cover Image (Background)
              Container(
                height: coverHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Layer B: The Profile Image using Positioned
              Positioned(
                // Positioned relative to the Stack.
                // To center it vertically over the line, we set 'bottom' to negative half height.
                bottom: -(profileHeight / 2),
                // To center horizontally using Positioned, we anchor left and right to 0
                // and the container inside will center itself.
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundColor: Colors.green, // White border effect
                  child: CircleAvatar(
                    radius: (profileHeight / 2) - 4, // Slightly smaller for border
                    backgroundImage: const //NetworkImage('https://i.pravatar.cc/300', // Random placeholder image
                    //),
                    AssetImage('assets/images/dhruv.jpg'),),
                ),
              ),
            ],
          ),

          // 2. THE CONTENT SECTION
          // We need spacing to account for the half of the image hanging down
          SizedBox(height: (profileHeight / 2) + 20),

          // Name
          const Text(
            'Dhruv M Patel ',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // Job Title
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          // Bio
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Passionate about building beautiful mobile apps. '
                  'Loves coffee, clean code, and open source contributing.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}