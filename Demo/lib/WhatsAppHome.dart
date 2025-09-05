// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WhatsAppHomeUI(),
//   ));
// }
//
// class WhatsAppHomeUI extends StatelessWidget {
//   const WhatsAppHomeUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Camera + 3 tabs
//       initialIndex: 1, // Start from "Chats"
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('WhatsApp'),
//           backgroundColor: Colors.teal[800],
//           actions: const [
//             Icon(Icons.camera_alt),
//             SizedBox(width: 20),
//             Icon(Icons.search),
//             SizedBox(width: 10),
//             Icon(Icons.more_vert),
//             SizedBox(width: 10),
//           ],
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(icon: Icon(Icons.camera_alt)),
//               Tab(text: 'CHATS'),
//               Tab(text: 'STATUS'),
//               Tab(text: 'CALLS'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             Center(child: Text('Camera', style: TextStyle(fontSize: 18))),
//             Center(child: Text('Chats', style: TextStyle(fontSize: 18))),
//             Center(child: Text('Status', style: TextStyle(fontSize: 18))),
//             Center(child: Text('Calls', style: TextStyle(fontSize: 18))),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Add new chat or call action
//           },
//           backgroundColor: Colors.teal,
//           child: const Icon(Icons.message),
//         ),
//       ),
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WhatsAppHomeUI(),
//   ));
// }
//
// class WhatsAppHomeUI extends StatelessWidget {
//   const WhatsAppHomeUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Dummy chat data
//     List<Map<String, String>> chats = [
//       {
//         'name': 'Alice',
//         'message': 'Hey! How are you?',
//         'time': '10:20 AM',
//         'image': 'https://i.pravatar.cc/150?img=1',
//       },
//       {
//         'name': 'Bob',
//         'message': 'Let’s catch up tomorrow.',
//         'time': '09:45 AM',
//         'image': 'https://i.pravatar.cc/150?img=2',
//       },
//       {
//         'name': 'Charlie',
//         'message': 'Meeting at 5 PM.',
//         'time': 'Yesterday',
//         'image': 'https://i.pravatar.cc/150?img=3',
//       },
//       {
//         'name': 'Diana',
//         'message': 'Can you send the file?',
//         'time': 'Monday',
//         'image': 'https://i.pravatar.cc/150?img=4',
//       },
//     ];
//
//     return DefaultTabController(
//       length: 4,
//       initialIndex: 1, // Start at Chats
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('WhatsApp'),
//           backgroundColor: Colors.teal[800],
//           actions: const [
//             Icon(Icons.camera_alt),
//             SizedBox(width: 20),
//             Icon(Icons.search),
//             SizedBox(width: 10),
//             Icon(Icons.more_vert),
//             SizedBox(width: 10),
//           ],
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(icon: Icon(Icons.camera_alt)),
//               Tab(text: 'CHATS'),
//               Tab(text: 'STATUS'),
//               Tab(text: 'CALLS'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             const Center(child: Text('Camera')),
//             // 🟢 Chats Tab
//             ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(chats[index]['image']!),
//                     radius: 25,
//                   ),
//                   title: Text(chats[index]['name']!,
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text(chats[index]['message']!),
//                   trailing: Text(chats[index]['time']!,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                   onTap: () {
//                     // open chat screen
//                   },
//                 );
//               },
//             ),
//             const Center(child: Text('Status')),
//             const Center(child: Text('Calls')),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Add new chat
//           },
//           backgroundColor: Colors.teal,
//           child: const Icon(Icons.message),
//         ),
//       ),
//     );
//   }
// }


// mautipul chat list
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WhatsAppHomeUI(),
//   ));
// }
//
// class WhatsAppHomeUI extends StatelessWidget {
//   const WhatsAppHomeUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Generate 20 dummy chats
//     List<Map<String, String>> chats = List.generate(20, (index) {
//       return {
//         'name': 'User ${index + 1}',
//         'message': 'Hello from User ${index + 1}',
//         'time': '${9 + (index % 12)}:${index % 60} AM',
//         'image': 'https://i.pravatar.cc/150?img=${index + 1}',
//       };
//     });
//
//     return DefaultTabController(
//       length: 4,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('WhatsApp'),
//           backgroundColor: Colors.green,
//           actions: const [
//             Icon(Icons.camera_alt),
//             SizedBox(width: 20),
//             Icon(Icons.search),
//             SizedBox(width: 10),
//             Icon(Icons.more_vert),
//             SizedBox(width: 10),
//           ],
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(icon: Icon(Icons.camera_alt)),
//               Tab(text: 'CHATS'),
//               Tab(text: 'STATUS'),
//               Tab(text: 'CALLS'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             const Center(child: Text('Camera')),
//             // 🔽 Chat List
//             ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(chats[index]['image']!),
//                     radius: 25,
//                   ),
//                   title: Text(
//                     chats[index]['name']!,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(chats[index]['message']!),
//                   trailing: Text(
//                     chats[index]['time']!,
//                     style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                   onTap: () {
//                     // Navigate to individual chat screen (not implemented here)
//                   },
//                 );
//               },
//             ),
//             const Center(child: Text('Status')),
//             const Center(child: Text('Calls')),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Add new chat action
//           },
//           backgroundColor: Colors.teal,
//           child: const Icon(Icons.message),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsAppHomeUI(),
  ));
}

class WhatsAppHomeUI extends StatelessWidget {
  const WhatsAppHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Dummy chat list
    List<Map<String, String>> chats = List.generate(20, (index) {
      return {
        'name': 'User ${index + 1}',
        'message': 'Hello from User ${index + 1}',
        'time': '${9 + (index % 12)}:${index % 60} AM',
        'image': 'https://i.pravatar.cc/150?img=${index + 1}',
      };
    });

    // 🔹 Dummy status list
    List<Map<String, String>> statuses = List.generate(15, (index) {
      return {
        'name': 'Status ${index + 1}',
        'time': '${index + 1}:00 AM',
        'image': 'https://i.pravatar.cc/150?img=${index + 21}',
      };
    });

    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          backgroundColor: Colors.teal[800],
          actions: const [
            Icon(Icons.camera_alt),
            SizedBox(width: 20),
            Icon(Icons.search),
            SizedBox(width: 10),
            Icon(Icons.more_vert),
            SizedBox(width: 10),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('Camera')),

            // 🟢 CHATS Tab
            ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chats[index]['image']!),
                    radius: 25,
                  ),
                  title: Text(chats[index]['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(chats[index]['message']!),
                  trailing: Text(chats[index]['time']!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  onTap: () {},
                );
              },
            ),

            // 🟡 STATUS Tab
            ListView.builder(
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(statuses[index]['image']!),
                    radius: 25,
                  ),
                  title: Text(statuses[index]['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Today at ${statuses[index]['time']}"),
                  onTap: () {},
                );
              },
            ),

            // 🔴 CALLS Tab
            const Center(child: Text('Calls')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new chat/status
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.message),
        ),
      ),
    );
  }
}
