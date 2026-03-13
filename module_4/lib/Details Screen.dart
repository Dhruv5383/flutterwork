// import 'package:flutter/material.dart';
// //import '../models/product.dart';
// import 'Product.dart';
//
// class DetailsScreen extends StatelessWidget {
//   final Product product;
//
//   DetailsScreen({required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               product.image,
//               height: 200,
//             ),
//             SizedBox(height: 20),
//             Text(
//               product.name,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "\$${product.price}",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





//--------------------------------------------------------------------------------
// quantity, calculate
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../models/product.dart';
//import '../providers/cart_provider.dart';
import 'Cart Provider.dart';
import 'Product.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  DetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Hero(
            tag: product.id,
            child: Image.asset(product.image, height: 250),
          ),
          SizedBox(height: 20),
          Text(product.name, style: TextStyle(fontSize: 24)),
          Text("\$${product.price}", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              cart.addToCart(product);
            },
            child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}