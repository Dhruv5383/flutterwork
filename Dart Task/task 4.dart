import 'dart:io';
import 'task 5.dart';

void main(List<String> args) {
  int? choice;
  List<PizzaOffers> l1 = [];

  print('|--------------------------------------------------------|');
  print('|                    Available offers                    |');
  print('|--------------------------------------------------------|');
  print('| Size     | Quantity | Price | Offer                    |');
  print('|--------------------------------------------------------|');
  print('| Small    |    4     |  150  | 500ml Coke               |');
  print('| Medium   |    3     |  250  | 1 Ltr Coke               |');
  print('| Large    |    2     |  500  | 1 Ice Cream + 500ml Coke |');
  print('| Monster  |    1     |  750  | 2 Ltr Coke + 1 Ice Cream |');
  print('|--------------------------------------------------------|');

  do {
    print('Enter 1 for Small, 2 for Medium, 3 for Large, 4 for Monster');
    int sizeChoice = int.parse(stdin.readLineSync()!);

    PizzaOffers pizzaInfo = getSizeInfo(sizeChoice);

    print('Enter the quantity for ${getSizeInfo(sizeChoice).size}');
    int qty = int.parse(stdin.readLineSync()!);

    l1.add(
      PizzaOffers(
        size: pizzaInfo.size,
        offerQty: pizzaInfo.offerQty,
        qty: qty,
        price: pizzaInfo.price,
        offer: pizzaInfo.offer,
        pizzaPrice: pizzaInfo.pizzaPrice,
      ),
    );

    print('Enter 0 to get invoice, 1 to add another size');
    choice = int.parse(stdin.readLineSync()!);
  } while (choice != 0);

  printInvoice(l1);
  calculateTotalPrice(l1);
  calculateOffer(l1);
}

void printInvoice(List<PizzaOffers> l1) {
  print('|--------------------------------------------------------|');
  print('|                        Invoice                         |');
  print('|--------------------------------------------------------|');
  print('| Size     | Quantity | Price per unit   | Total Price   |');
  print('|--------------------------------------------------------|');
}

void calculateOffer(List<PizzaOffers> l1) {
  int offeredQty = 0;
  for (int i = 0; i < l1.length; i++) {
    offeredQty = l1[i].qty ~/ l1[i].offerQty;
    if (offeredQty > 0) {
      print(
        'You are getting $offeredQty (${l1[i].offer}) for ${l1[i].qty} ${l1[i].size} Pizzas',
      );
    } else {
      print('No offer for ${l1[i].size}');
    }
  }
}

void calculateTotalPrice(List<PizzaOffers> l1) {
  int totalPrice = 0;
  int pizaPrice = 0;

  for (int i = 0; i < l1.length; i++) {
    totalPrice = l1[i].qty * l1[i].price + totalPrice;
    pizaPrice = l1[i].qty * l1[i].price;
    print(
      ' ${l1[i].size}          ${l1[i].qty}          ${l1[i].price}    ₹$pizaPrice',
    );
    // print('Price for ${l1[i].qty} ${l1[i].size} Pizzas is ₹$pizaPrice');
  }
  print('Billable amount is ₹$totalPrice');
}

PizzaOffers getSizeInfo(int sizeChoice) {
  if (sizeChoice == 1) {
    return PizzaOffers(
      size: 'Small',
      offerQty: 4,
      qty: 0,
      price: 150,
      offer: '500ml Coke',
      pizzaPrice: 0,
    );
  } else if (sizeChoice == 2) {
    return PizzaOffers(
      size: 'Medium',
      offerQty: 3,
      qty: 0,
      price: 250,
      offer: '1 Ltr Coke',
      pizzaPrice: 0,
    );
  } else if (sizeChoice == 3) {
    return PizzaOffers(
      size: 'Large',
      offerQty: 2,
      qty: 0,
      price: 500,
      offer: '1 Ice Cream + 500ml Coke',
      pizzaPrice: 0,
    );
  } else if (sizeChoice == 4) {
    return PizzaOffers(
      size: 'Monster',
      offerQty: 1,
      qty: 0,
      price: 750,
      offer: '1 Ltr Coke + Ice Cream',
      pizzaPrice: 0,
    );
  } else {
    print('Invalid input');
    return PizzaOffers(
      size: '',
      offerQty: 0,
      qty: 0,
      price: 0,
      offer: '',
      pizzaPrice: 0,
    );
  }
}
