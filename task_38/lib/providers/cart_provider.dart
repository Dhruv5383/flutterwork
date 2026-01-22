import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItemModel> _items = {};
  double _discount = 0;

  Map<String, CartItemModel> get items => _items;

  double get subTotal =>
      _items.values.fold(0, (sum, item) => sum + item.total);

  double get discount => _discount;

  double get total => subTotal - _discount;

  void addItem(String name, double price) {
    _items.containsKey(name)
        ? _items[name]!.qty++
        : _items[name] = CartItemModel(price: price);
    notifyListeners();
  }

  void removeItem(String name) {
    if (!_items.containsKey(name)) return;
    _items[name]!.qty > 1
        ? _items[name]!.qty--
        : _items.remove(name);
    notifyListeners();
  }

  void applyCoupon(String code) {
    if (code == "SAVE10") {
      _discount = subTotal * 0.1;
    } else {
      _discount = 0;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _discount = 0;
    notifyListeners();
  }
}
