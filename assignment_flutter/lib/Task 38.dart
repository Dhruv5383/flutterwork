// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'Task 38_2 cart modul ( provider ).dart';
// // //import 'cart_provider.dart';
// //
// // class ShoppingCartScreen extends StatefulWidget {
// //   const ShoppingCartScreen({super.key});
// //
// //   @override
// //   State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
// // }
// //
// // class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
// //   final List<Map<String, dynamic>> products = [
// //     {'name': 'Apple', 'price': 30.0},
// //     {'name': 'Banana', 'price': 10.0},
// //     {'name': 'Orange', 'price': 20.0},
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final cart = Provider.of<CartProvider>(context);
// //
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Shopping Cart')),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: products.length,
// //               itemBuilder: (context, index) {
// //                 final item = products[index];
// //                 final isAdded = cart.items.containsKey(item['name']);
// //
// //                 return ListTile(
// //                   title: Text(item['name']),
// //                   subtitle: Text('₹${item['price']}'),
// //                   trailing: IconButton(
// //                     icon: Icon(
// //                       isAdded ? Icons.remove_circle : Icons.add_circle,
// //                       color: isAdded ? Colors.red : Colors.green,
// //                     ),
// //                     onPressed: () {
// //                       isAdded
// //                           ? cart.removeItem(item['name'])
// //                           : cart.addItem(item['name'], item['price']);
// //                     },
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //
// //           // TOTAL PRICE (REAL-TIME)
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             child: Consumer<CartProvider>(
// //               builder: (context, cart, _) {
// //                 return Text(
// //                   'Total: ₹${cart.totalPrice}',
// //                   style: const TextStyle(
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'Task 38_2 cart modul ( provider ).dart';
// import 'Task 38_3 Reusable CartItem Widget.dart';
//
//
// class ShoppingCartScreen extends StatefulWidget {
//   const ShoppingCartScreen({super.key});
//
//   @override
//   State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
// }
//
// class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
//   final products = [
//     {'name': 'Apple', 'price': 30.0},
//     {'name': 'Banana', 'price': 10.0},
//     {'name': 'Orange', 'price': 20.0},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Advanced Cart')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: products.map((product) {
//                 final item = cart.items[product['name']];
//                 return
//                   CartItem(
//                   name: product['name'],
//                   price: product['price'],
//                   qty: item?['qty'] ?? 0,
//                   onAdd: () =>
//                       cart.addItem(product['name'], product['price']),
//                   onRemove: () =>
//                       cart.removeItem(product['name']),
//                 );
//               }).toList(),
//             ),
//           ),
//
//           // 🎞️ Animated Total
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0, end: cart.totalPrice),
//               duration: const Duration(milliseconds: 400),
//               builder: (context, value, _) {
//                 return Text(
//                   'Total: ₹${value.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
