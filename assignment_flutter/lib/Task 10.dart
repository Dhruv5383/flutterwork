//1 StatefulWidget
// import 'package:flutter/material.dart';
//
// class ShoppingCartApp extends StatefulWidget {
//   const ShoppingCartApp({super.key});
//
//   @override
//   State<ShoppingCartApp> createState() => _ShoppingCartAppState();
// }
//
// class _ShoppingCartAppState extends State<ShoppingCartApp> {
//   // List of products
//   final List<String> items = [
//     'Apple',
//     'Banana',
//     'Mango',
//     'Orange',
//     'Grapes',
//     'Watermelon',
//   ];
//
//   int cartCount = 0; // Tracks total items in the cart
//
//   void addToCart() {
//     setState(() {
//       cartCount++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shopping Cart'),
//         backgroundColor: Colors.blueAccent,
//         actions: [
//           // Shopping cart icon with item counter
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 const Icon(Icons.shopping_cart, size: 28),
//                 if (cartCount > 0)
//                   Positioned(
//                     right: 0,
//                     top: 5,
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         '$cartCount',
//                         style:
//                         const TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//       // Item list
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             elevation: 3,
//             child: ListTile(
//               leading: const Icon(Icons.shopping_bag, color: Colors.blueAccent),
//               title: Text(
//                 items[index],
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               trailing: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                 ),
//                 onPressed: addToCart,
//                 child: const Text(
//                   'Add to Cart',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//2 StatefulWidget
import 'package:flutter/material.dart';

class ShoppingCartApp extends StatefulWidget {
  const ShoppingCartApp({super.key});

  @override
  State<ShoppingCartApp> createState() => _ShoppingCartAppState();
}

class _ShoppingCartAppState extends State<ShoppingCartApp> {
  // 🛒 Expanded product list
  final List<String> items = [
    'Apple',
    'Banana',
    'Mango',
    'Orange',
    'Grapes',
    'Watermelon',
    'Pineapple',
    'Strawberry',
    'Blueberry',
    'Tomato',
    'Potato',
    'Carrot',
    'Onion',
    'Cucumber',
    'Laptop',
    'Headphones',
    'Smartwatch',
    'Mobile Phone',
    'T-shirt',
    'Jeans',
    'Sneakers',
    'Jacket',
    'Backpack',
    'Sunglasses',
    'Perfume',
  ];

  int cartCount = 0; // Tracks total items in the cart

  void addToCart() {
    setState(() {
      cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.blueAccent,
        actions: [
          // 🛒 Shopping cart icon with item counter
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_cart, size: 28),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 5,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$cartCount',
                        style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      // 🧾 Product list
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.blueAccent),
              title: Text(
                items[index],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: addToCart,
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//3 StatelessWidget
// import 'package:flutter/material.dart';
//
// class ShoppingCartApp extends StatelessWidget {
//   const ShoppingCartApp({super.key});
//
//   // List of items
//   final List<String> items = const [
//     'Apple',
//     'Banana',
//     'Mango',
//     'Orange',
//     'Grapes',
//     'Watermelon',
//     'Pineapple',
//     'Strawberry',
//     'Blueberry',
//     'Tomato',
//     'Potato',
//     'Carrot',
//     'Onion',
//     'Cucumber',
//     'Laptop',
//     'Headphones',
//     'Smartwatch',
//     'Mobile Phone',
//     'T-shirt',
//     'Jeans',
//     'Sneakers',
//     'Jacket',
//     'Backpack',
//     'Sunglasses',
//     'Perfume',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shopping Cart '),
//         backgroundColor: Colors.blueAccent,
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: Icon(Icons.shopping_cart, size: 28),
//           ),
//         ],
//       ),
//
//       // Product List
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             elevation: 3,
//             child: ListTile(
//               leading: const Icon(Icons.shopping_bag, color: Colors.blueAccent),
//               title: Text(
//                 items[index],
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               trailing: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                 ),
//                 onPressed: () {
//                   print('${items[index]} added to cart');
//                 },
//                 child: const Text(
//                   'Add to Cart',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
