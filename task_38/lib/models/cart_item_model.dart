import 'package:flutter/material.dart';

class CartItemModel {
  final double price;
  int qty;

  CartItemModel({required this.price, this.qty = 1});

  double get total => price * qty;
}
