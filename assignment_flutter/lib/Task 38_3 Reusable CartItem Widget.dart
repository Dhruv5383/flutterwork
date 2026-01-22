import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final double price;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Text('₹${widget.price} × ${widget.qty}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: widget.onRemove,
          ),
          Text(widget.qty.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: widget.onAdd,
          ),
        ],
      ),
    );
  }
}
