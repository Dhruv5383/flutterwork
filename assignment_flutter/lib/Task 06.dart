// import 'package:flutter/material.dart';
//
// class ProfileCardApp extends StatelessWidget {
//   const ProfileCardApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           title: const Text('Profile Card'),
//           backgroundColor: Colors.blue,
//         ),
//         body: Center(
//           child: Card(
//             elevation: 8,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             margin: const EdgeInsets.all(20),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 40,
//                         backgroundImage: AssetImage('assets/images/img.png',)
//                       ),
//                       const SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Dhruv Patel',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             'Flutter Developer',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Passionate about building beautiful and responsive mobile applications using Flutter. Loves clean code and UI design.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }


// import 'package:flutter/material.dart';
//
// class ProfileCardApp extends StatelessWidget {
//   const ProfileCardApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           title: const Text('Profile Card'),
//           backgroundColor: Colors.blue,
//         ),
//         body: Center(
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black54,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             margin: const EdgeInsets.all(20),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Profile Row
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 45,
//                         backgroundImage: NetworkImage(
//                           'https://i.pravatar.cc/150?img=8',
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Dhruv Patel',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             'Flutter Developer',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Bio
//                   const Text(
//                     'Enthusiastic Flutter Developer with a passion for creating beautiful, responsive, and user-friendly apps. Always learning and exploring new tech!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//                   const Divider(),
//
//                   // Contact Info
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.email, color: Colors.blue),
//                       SizedBox(width: 8),
//                       Text(
//                         'dhruv@example.com',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(width: 20),
//                       Icon(Icons.phone, color: Colors.green),
//                       SizedBox(width: 8),
//                       Text(
//                         '+91 98765 43210',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//                   const Divider(),
//
//                   // Social Media Icons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.facebook, color: Colors.blue, size: 30),
//                       SizedBox(width: 20),
//                       Icon(Icons.linked_camera, color: Colors.purple, size: 30),
//                       SizedBox(width: 20),
//                       Icon(Icons.alternate_email, color: Colors.red, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }



import 'package:flutter/material.dart';

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Profile Cards'),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ---- FIRST PROFILE CARD ----
            profileCard(
              context,
              name: 'Dhruv Patel',
              role: 'Flutter Developer',
              imageUrl: 'https://i.pravatar.cc/150?img=12',
              location: 'Ahmedabad, India',
              email: 'dhruv@example.com',
              phone: '+91 98765 43210',
              bio:
              'Passionate Flutter Developer who loves building responsive mobile apps and exploring new tech.',
            ),
            const SizedBox(height: 20),

            // ---- SECOND PROFILE CARD ----
            profileCard(
              context,
              name: 'Panda Patel',
              role: 'UI/UX Designer',
              imageUrl: 'https://i.pravatar.cc/150?img=47',
              location: 'Mumbai, India',
              email: 'riya@example.com',
              phone: '+91 91234 56789',
              bio:
              'Creative designer focused on crafting beautiful, user-centered mobile and web experiences.',
            ),
          ],
        ),
      );
  }

  // Profile Card Widget
  Widget profileCard(
      BuildContext context, {
        required String name,
        required String role,
        required String imageUrl,
        required String location,
        required String email,
        required String phone,
        required String bio,
      }) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 45, backgroundImage: NetworkImage(imageUrl)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(role,
                        style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.redAccent, size: 18),
                        const SizedBox(width: 5),
                        Text(location,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              bio,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.blue),
                const SizedBox(width: 8),
                Text(email, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 8),
                Text(phone, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.facebook, color: Colors.blue, size: 30),
                SizedBox(width: 20),
                Icon(Icons.camera_alt, color: Colors.purple, size: 30),
                SizedBox(width: 20),
                Icon(Icons.alternate_email,
                    color: Colors.redAccent, size: 30),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Followed $name!')),
                    );
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Follow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message sent to $name!')),
                    );
                  },
                  icon: const Icon(Icons.message, color: Colors.blueAccent),
                  label: const Text('Message',
                      style: TextStyle(color: Colors.blueAccent)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blueAccent),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
