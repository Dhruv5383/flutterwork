import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: couponController,
              decoration: const InputDecoration(
                labelText: 'Coupon Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => cart.applyCoupon(couponController.text),
              child: const Text('Apply Coupon'),
            ),

            const Divider(height: 30),

            Text('Subtotal: ₹${cart.subTotal.toStringAsFixed(0)}'),
            Text('Discount: ₹${cart.discount.toStringAsFixed(0)}'),
            const SizedBox(height: 10),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: cart.total),
              duration: const Duration(milliseconds: 400),
              builder: (_, value, __) => Text(
                'Total: ₹${value.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                Navigator.pop(context);
              },
              child: const Text('Place Order'),
            )
          ],
        ),
      ),
    );
  }
}
