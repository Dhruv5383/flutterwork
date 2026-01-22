import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartBadge extends StatefulWidget {
  const CartBadge({super.key});

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    final count = context.watch<CartProvider>().items.length;

    return Stack(
      children: [
        const Icon(Icons.shopping_cart),
        if (count > 0)
          Positioned(
            right: 0,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
