import 'package:flutter/material.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int selectedIndex = 0;

  // Content for each tab
  final List<Widget> screens = const [
    Center(child: Text("News Screen", style: TextStyle(fontSize: 24))),
    Center(child: Text("Messages Screen", style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile Screen", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fluuter Navigation Bar"),backgroundColor: Colors.cyanAccent,),

      // Changing Screen
      body: screens[selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}







// task 23 and 24 join
// import 'package:flutter/material.dart';
//
// class Task_23_24 extends StatefulWidget {
//   const Task_23_24({Key? key}) : super(key: key);
//
//   @override
//   State<Task_23_24> createState() => _Task_23_24State();
// }
//
// class _Task_23_24State extends State<Task_23_24> {
//   int _drawerIndex = 0;
//   int _bottomIndex = 0;
//
//   final List<String> _drawerPages = ['Home', 'Profile', 'Settings'];
//   final List<String> _bottomTabs = ['News', 'Messages', 'Profile'];
//
//   void _selectDrawer(int index) {
//     setState(() {
//       _drawerIndex = index;
//     });
//     Navigator.pop(context);
//   }
//
//   void _selectBottom(int index) {
//     setState(() {
//       _bottomIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Task 23 & 24',
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Center(
//                 child: Text(
//                   'Navigation Menu',
//                   style: TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () => _selectDrawer(0),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Profile'),
//               onTap: () => _selectDrawer(1),
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () => _selectDrawer(2),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Drawer Page: ${_drawerPages[_drawerIndex]}',
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Bottom Tab: ${_bottomTabs[_bottomIndex]}',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _bottomIndex,
//         onTap: _selectBottom,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
//           BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }