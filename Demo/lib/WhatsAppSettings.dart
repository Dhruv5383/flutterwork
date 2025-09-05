// import 'package:flutter/material.dart';
//
// class WhatsAppSettingsApp extends StatelessWidget {
//   const WhatsAppSettingsApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WhatsApp Settings',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.teal),
//       home: const WhatsAppSettingsPage(),
//     );
//   }
// }
//
// class WhatsAppSettingsPage extends StatelessWidget {
//   const WhatsAppSettingsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         backgroundColor: Colors.teal[800],
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 10),
//           // Profile section
//           ListTile(
//             leading: CircleAvatar(
//               radius: 30,
//               backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your asset
//             ),
//             title: const Text('Your Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             subtitle: const Text('Hey there! I am using WhatsApp.'),
//             trailing: Icon(Icons.qr_code),
//             onTap: () {
//               // Navigate to Profile Edit page
//             },
//           ),
//           const Divider(),
//
//           // Settings items
//           SettingsTile(
//             icon: Icons.key,
//             title: 'Account',
//             subtitle: 'Privacy, security, change number',
//           ),
//           SettingsTile(
//             icon: Icons.lock,
//             title: 'Privacy',
//             subtitle: 'Block contacts, disappearing messages',
//           ),
//           SettingsTile(
//             icon: Icons.chat,
//             title: 'Chats',
//             subtitle: 'Theme, wallpapers, chat history',
//           ),
//           SettingsTile(
//             icon: Icons.notifications,
//             title: 'Notifications',
//             subtitle: 'Message, group & call tones',
//           ),
//           SettingsTile(
//             icon: Icons.storage,
//             title: 'Storage and data',
//             subtitle: 'Network usage, auto-download',
//           ),
//           SettingsTile(
//             icon: Icons.language,
//             title: 'App language',
//             subtitle: 'English (phone’s language)',
//           ),
//           SettingsTile(
//             icon: Icons.help_outline,
//             title: 'Help',
//             subtitle: 'Help center, contact us, privacy policy',
//           ),
//           SettingsTile(
//             icon: Icons.group,
//             title: 'Invite a friend',
//             subtitle: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SettingsTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//
//   const SettingsTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.teal[800]),
//       title: Text(title, style: const TextStyle(fontSize: 16)),
//       subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
//       onTap: () {
//         // Handle tap
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsAppSettingsUI(),
  ));
}

class WhatsAppSettingsUI extends StatelessWidget {
  const WhatsAppSettingsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal[800],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
            ),
            title: const Text('Your Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: const Text('Hey there! I am using WhatsApp.'),
            trailing: const Icon(Icons.qr_code),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.key, color: Colors.teal[800]),
            title: const Text('Account'),
            subtitle: const Text('Privacy, security, change number'),
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.teal[800]),
            title: const Text('Privacy'),
            subtitle: const Text('Block contacts, disappearing messages'),
          ),
          ListTile(
            leading: Icon(Icons.chat, color: Colors.teal[800]),
            title: const Text('Chats'),
            subtitle: const Text('Theme, wallpapers, chat history'),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.teal[800]),
            title: const Text('Notifications'),
            subtitle: const Text('Message, group & call tones'),
          ),
          ListTile(
            leading: Icon(Icons.storage, color: Colors.teal[800]),
            title: const Text('Storage and data'),
            subtitle: const Text('Network usage, auto-download'),
          ),
          ListTile(
            leading: Icon(Icons.language, color: Colors.teal[800]),
            title: const Text('App language'),
            subtitle: const Text('English (phone’s language)'),
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.teal[800]),
            title: const Text('Help'),
            subtitle: const Text('Help center, contact us, privacy policy'),
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.teal[800]),
            title: const Text('Invite a friend'),
          ),
        ],
      ),
    );
  }
}
