import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item_model.dart';

final cartProvider =
StateNotifierProvider<CartNotifier, Map<String, CartItemModel>>(
      (ref) => CartNotifier(),
);

class StateNotifierProvider {
}

class CartNotifier extends StateNotifier<Map<String, CartItemModel>> {
  CartNotifier() : super({});

  double get total =>
      state.values.fold(0, (sum, item) => sum + item.total);

  void addItem(String name, double price) {
    final map = {...state};
    map.containsKey(name)
        ? map[name]!.qty++
        : map[name] = CartItemModel(price: price);
    var state = map;
  }

  void removeItem(String name) {
    final map = {...state};
    if (!map.containsKey(name)) return;
    map[name]!.qty > 1 ? map[name]!.qty-- : map.remove(name);
    var state = map;
  }

  void clear(Map<dynamic, dynamic> state) => state = {};
}

class state {
}

class StateNotifier {
}
