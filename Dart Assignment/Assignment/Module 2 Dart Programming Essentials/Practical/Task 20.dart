// // Write a program that simulates a shopping cart. Define classes for Product, Cart, and Order.
// // Allow users to add products to the cart and calculate the total price of the items.

import 'dart:io';

class Product {
  final String id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => '$name (\$${price.toStringAsFixed(2)})';
}

class Cart {
  final Map<Product, int> _items = {};

  void addProduct(Product product, int quantity) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + quantity;
    } else {
      _items[product] = quantity;
    }
  }

  double get totalPrice {
    return _items.entries.fold(
      0.0,
      (total, entry) => total + (entry.key.price * entry.value),
    );
  }

  void display() {
    if (_items.isEmpty) {
      print('\nYour cart is empty');
      return;
    }

    print('\nYour Shopping Cart:');
    _items.forEach((product, quantity) {
      print(
        '${product.name} x $quantity = \$${(product.price * quantity).toStringAsFixed(2)}',
      );
    });
    print('-------------------------------');
    print('Total: \$${totalPrice.toStringAsFixed(2)}\n');
  }
}

class Order {
  final String id;
  final Cart cart;
  final DateTime date;

  Order(this.id, this.cart, this.date);

  void display() {
    print('\nOrder #$id');
    print('Date: ${date.year}-${date.month}-${date.day}');
    cart.display();
  }
}

void main() {
  // Available products
  final products = [
    Product('1', 'Laptop', 999.99),
    Product('2', 'Smartphone', 699.99),
    Product('3', 'Headphones', 199.99),
    Product('4', 'Mouse', 29.99),
    Product('5', 'Keyboard', 59.99),
  ];

  final cart = Cart();
  bool checkingOut = false;

  while (!checkingOut) {
    print('\nAvailable Products:');
    products.forEach((product) {
      print(
        '${product.id}. ${product.name} - \$${product.price.toStringAsFixed(2)}',
      );
    });
    print('6. Checkout');
    print('7. View Cart');
    print('8. Exit');

    stdout.write('\nEnter your choice: ');
    final choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
        final product = products[int.parse(choice!) - 1];
        stdout.write('Enter quantity for ${product.name}: ');
        final quantityInput = stdin.readLineSync();
        final quantity = int.tryParse(quantityInput ?? '1') ?? 1;

        cart.addProduct(product, quantity);
        print('\nAdded $quantity ${product.name}(s) to cart');
        break;

      case '6':
        if (cart.totalPrice == 0) {
          print('\nYour cart is empty. Add items first.');
          break;
        }
        checkingOut = true;
        break;

      case '7':
        cart.display();
        break;

      case '8':
        print('\nGoodbye!');
        return;

      default:
        print('\nInvalid choice. Please try again.');
        break;
    }
  }

  // Create order
  final order = Order(
    'ORD-${DateTime.now().millisecondsSinceEpoch}',
    cart,
    DateTime.now(),
  );

  order.display();
  print('\nThank you for your order!');
}
