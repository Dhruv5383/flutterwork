// quantity, calculate
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../providers/cart_provider.dart';
//import '../models/product.dart';
import 'Cart Provider.dart';
import 'Product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.cartProducts.map((Product product) {
                int quantity = cart.items[product.id]!;

                return ListTile(
                  leading: Image.asset(product.image, width: 50),
                  title: Text(product.name),
                  subtitle: Text(
                      "₹${product.price} x $quantity = ₹${product.price * quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => cart.decrease(product),
                        icon: Icon(Icons.remove),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        onPressed: () => cart.increase(product),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Total: ₹${cart.totalPrice()}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}