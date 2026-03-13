// import 'package:flutter/material.dart';
//
// //import '../models/product.dart';
// import 'Product.dart';
//
// class ProductListScreen extends StatelessWidget {
//
//   final List<Product> products = [
//     Product(
//       id: 1,
//       name: "iPhone",
//       price: 999,
//       image: "assets/images/iphone.png",
//     ),
//     Product(
//       id: 2,
//       name: "Laptop",
//       price: 1200,
//       image: "assets/images/laptop.png",
//     ),
//     Product(
//       id: 3,
//       name: "Shoes",
//       price: 2200,
//       image: "assets/images/shoes.png",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Products")),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               leading: Image.asset(
//                 product.image,
//                 width: 50,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(product.name),
//               subtitle: Text("\$${product.price}"),
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/details',
//                   arguments: product,
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }








//--------------------------------------------------------------
// quantity, calculate
import 'package:flutter/material.dart';

//import '../models/product.dart';
import 'Details Screen.dart';
import 'Product.dart';
//import 'details_screen.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: 1,
      name: "iPhone",
      price: 999,
      image: "assets/images/iphone.png",
    ),
    Product(
      id: 2,
      name: "Laptop",
      price: 1200,
      image: "assets/images/laptop.png",
    ),
    Product(
      id: 3,
      name: "Shoes",
      price: 2200,
      image: "assets/images/shoes.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            child: ListTile(
              leading: Hero(
                tag: product.id,
                child: Image.asset(product.image, width: 50),
              ),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
