import 'package:flutter/material.dart';

import '../widgets/cart_badge.dart';
import 'checkout_screen.dart';

class demo_38 extends StatefulWidget {
  const demo_38({super.key});

  @override
  State<demo_38> createState() => _demo38State();
}

class _demo38State extends State<demo_38> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Cart'),
      actions: [
        IconButton(
          icon: const CartBadge(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
            );
          },
        )
      ],
    ),
    );
  }
}
