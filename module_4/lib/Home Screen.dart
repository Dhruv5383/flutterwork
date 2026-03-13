// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/products');
//           },
//           child: Text("View Products"),
//         ),
//       ),
//     );
//   }
// }



//------------------------------------------------------------
// quantity, calculate
import 'package:flutter/material.dart';

import 'Cart Screen.dart';
import 'Product List Screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    //HomeScreen(),
    ProductListScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
    );
  }
}