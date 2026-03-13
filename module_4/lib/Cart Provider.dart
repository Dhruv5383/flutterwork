// quantity, calculate
import 'package:flutter/material.dart';
//import '../models/product.dart';
import 'Product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _items = {}; // productId : quantity
  final List<Product> _products = [];

  Map<int, int> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id] = _items[product.id]! + 1;
    } else {
      _items[product.id] = 1;
      _products.add(product);
    }
    notifyListeners();
  }

  void increase(Product product) {
    _items[product.id] = _items[product.id]! + 1;
    notifyListeners();
  }

  void decrease(Product product) {
    if (_items[product.id]! > 1) {
      _items[product.id] = _items[product.id]! - 1;
    } else {
      _items.remove(product.id);
      _products.remove(product);
    }
    notifyListeners();
  }

  double totalPrice() {
    double total = 0;
    for (var product in _products) {
      total += product.price * _items[product.id]!;
    }
    return total;
  }

  List<Product> get cartProducts => _products;
}