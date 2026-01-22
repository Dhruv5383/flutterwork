// import 'package:flutter/material.dart';
//
// class CartProvider extends ChangeNotifier {
//   final Map<String, double> _items = {};
//
//   Map<String, double> get items => _items;
//
//   double get totalPrice {
//     double total = 0;
//     _items.forEach((key, value) {
//       total += value;
//     });
//     return total;
//   }
//
//   void addItem(String name, double price) {
//     _items[name] = price;
//     notifyListeners();
//   }
//
//   void removeItem(String name) {
//     _items.remove(name);
//     notifyListeners();
//   }
// }


// cart modul (quantity + persistence)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _items = {};

  Map<String, Map<String, dynamic>> get items => _items;

  double get totalPrice {
    double total = 0;
    _items.forEach((key, item) {
      total += item['price'] * item['qty'];
    });
    return total;
  }

  void addItem(String name, double price) {
    if (_items.containsKey(name)) {
      _items[name]!['qty']++;
    } else {
      _items[name] = {'price': price, 'qty': 1};
    }
    saveCart();
    notifyListeners();
  }

  void removeItem(String name) {
    if (!_items.containsKey(name)) return;

    if (_items[name]!['qty'] > 1) {
      _items[name]!['qty']--;
    } else {
      _items.remove(name);
    }
    saveCart();
    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', jsonEncode(_items));
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('cart');
    if (data != null) {
      _items.clear();
      _items.addAll(
        Map<String, Map<String, dynamic>>.from(
          jsonDecode(data),
        ),
      );
      notifyListeners();
    }
  }
}
