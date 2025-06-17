// // // import 'dart:io';

// // // class Pizza {
// // //   final String size;
// // //   final int price;
// // //   final int quantity;
// // //   final String offer;

// // //   Pizza({
// // //     required this.size,
// // //     required this.price,
// // //     required this.quantity,
// // //     required this.offer,
// // //   });

// // //   void display() {
// // //     print('''
// // // ----------------------------------------
// // // Size:       $size
// // // Price:      $price
// // // Quantity:   $quantity
// // // Offer:      $offer
// // // ----------------------------------------
// // // ''');
// // //   }
// // // }

// // // void main() {
// // //   final pizzas = [
// // //     Pizza(size: 'Small', price: 150, quantity: 4, offer: '500ml Coke free'),
// // //     Pizza(size: 'Medium', price: 250, quantity: 3, offer: '1ltr Coke free'),
// // //     Pizza(
// // //       size: 'Large',
// // //       price: 550,
// // //       quantity: 4,
// // //       offer: 'Ice + 500ml Coke free',
// // //     ),
// // //     Pizza(size: 'Monster', price: 150, quantity: 4, offer: '1ltr + Ice cream'),
// // //   ];

// // //   print('\nWelcome to Pizza Menu!\n');
// // //   print('Available pizzas:');
// // //   for (int i = 0; i < pizzas.length; i++) {
// // //     print('  ${i + 1}. ${pizzas[i].size}');
// // //   }
// // //   print('  0. Exit\n');

// // //   while (true) {
// // //     stdout.write('Enter the number of the pizza to see details (0 to exit): ');
// // //     String? input = stdin.readLineSync();

// // //     if (input == null) {
// // //       print('Invalid input. Please try again.');
// // //       continue;
// // //     }

// // //     int? choice = int.tryParse(input);

// // //     if (choice == null || choice < 0 || choice > pizzas.length) {
// // //       print(
// // //         'Invalid choice. Please enter a number between 0 and ${pizzas.length}.',
// // //       );
// // //       continue;
// // //     }

// // //     if (choice == 0) {
// // //       print('Thank you for checking our Pizza Menu. Goodbye!');
// // //       break;
// // //     }

// // //     final selectedPizza = pizzas[choice - 1];
// // //     selectedPizza.display();
// // //   }
// // // }

// // import 'dart:io';

// // void main() {
// //   // Quantity counters
// //   int smallQty = 0;
// //   int mediumQty = 0;
// //   int largeQty = 0;
// //   int monsterQty = 0;

// //   String response = 'y';
// //   int totalAmount = 0;

// //   while (response.toLowerCase() == 'y') {
// //     print("-------------- Menu --------------");
// //     print("1. Small     - ₹150 per piece");
// //     print("2. Medium    - ₹250 per piece");
// //     print("3. Large     - ₹500 per piece");
// //     print("4. Monster   - ₹750 per piece");

// //     int choice = 0;
// //     while (choice < 1 || choice > 4) {
// //       stdout.write("Please enter a valid choice (1-4): ");
// //       choice = int.tryParse(stdin.readLineSync()!) ?? 0;
// //     }

// //     int price = 0;
// //     String itemName = '';
// //     switch (choice) {
// //       case 1:
// //         itemName = 'Small';
// //         price = 150;
// //         break;
// //       case 2:
// //         itemName = 'Medium';
// //         price = 250;
// //         break;
// //       case 3:
// //         itemName = 'Large';
// //         price = 500;
// //         break;
// //       case 4:
// //         itemName = 'Monster';
// //         price = 750;
// //         break;
// //     }

// //     stdout.write("Enter the quantity for $itemName: ");
// //     int qty = int.tryParse(stdin.readLineSync()!) ?? 0;

// //     int amount = price * qty;
// //     print("Amount: ₹$amount");

// //     totalAmount += amount;

// //     // Update quantity per item
// //     if (choice == 1) {
// //       smallQty += qty;
// //     } else if (choice == 2) {
// //       mediumQty += qty;
// //     } else if (choice == 3) {
// //       largeQty += qty;
// //     } else {
// //       monsterQty += qty;
// //     }

// //     stdout.write("Do you want to place more orders? (y/n): ");
// //     response = stdin.readLineSync() ?? 'n';
// //   }

// //   // Order summary
// //   print("\n---------------- Order Summary ----------------");
// //   print("Item      | Price | Quantity | Amount");
// //   print("----------------------------------------------");
// //   if (smallQty > 0) {
// //     print("Small     | 150   | $smallQty       | ${smallQty * 150}");
// //   }
// //   if (mediumQty > 0) {
// //     print("Medium    | 250   | $mediumQty       | ${mediumQty * 250}");
// //   }
// //   if (largeQty > 0) {
// //     print("Large     | 500   | $largeQty       | ${largeQty * 500}");
// //   }
// //   if (monsterQty > 0) {
// //     print("Monster   | 750   | $monsterQty       | ${monsterQty * 750}");
// //   }
// //   print("----------------------------------------------");
// //   print("Total Amount: ₹$totalAmount");
// // }

// import 'dart:io';

// void main() {
//   // Quantity counters
//   int smallQty = 0;
//   int mediumQty = 0;
//   int largeQty = 0;
//   int monsterQty = 0;

//   String response = 'y';
//   int totalAmount = 0;

//   while (response.toLowerCase() == 'y') {
//     print("-------------- Menu --------------");
//     print("1. Small     - ₹150 per piece");
//     print("2. Medium    - ₹250 per piece");
//     print("3. Large     - ₹500 per piece");
//     print("4. Monster   - ₹750 per piece");

//     int choice = 0;
//     while (choice < 1 || choice > 4) {
//       stdout.write("Please enter a valid choice (1-4): ");
//       choice = int.tryParse(stdin.readLineSync()!) ?? 0;
//     }

//     int price = 0;
//     String itemName = '';
//     switch (choice) {
//       case 1:
//         itemName = 'Small';
//         price = 150;
//         break;
//       case 2:
//         itemName = 'Medium';
//         price = 250;
//         break;
//       case 3:
//         itemName = 'Large';
//         price = 500;
//         break;
//       case 4:
//         itemName = 'Monster';
//         price = 750;
//         break;
//     }

//     stdout.write("Enter the quantity for $itemName: ");
//     int qty = int.tryParse(stdin.readLineSync()!) ?? 0;

//     int amount = price * qty;
//     print("Amount: ₹$amount");

//     totalAmount += amount;

//     // Update quantity per item
//     if (choice == 1) {
//       smallQty += qty;
//     } else if (choice == 2) {
//       mediumQty += qty;
//     } else if (choice == 3) {
//       largeQty += qty;
//     } else {
//       monsterQty += qty;
//     }

//     stdout.write("Do you want to place more orders? (y/n): ");
//     response = stdin.readLineSync() ?? 'n';
//   }

//   // Order summary
//   print("\n---------------- Order Summary ----------------");
//   print("Item      | Price | Quantity | Amount");
//   print("----------------------------------------------");
//   if (smallQty > 0) {
//     print("Small     | 150   | $smallQty       | ${smallQty * 150}");
//   }
//   if (mediumQty > 0) {
//     print("Medium    | 250   | $mediumQty       | ${mediumQty * 250}");
//   }
//   if (largeQty > 0) {
//     print("Large     | 500   | $largeQty       | ${largeQty * 500}");
//   }
//   if (monsterQty > 0) {
//     print("Monster   | 750   | $monsterQty       | ${monsterQty * 750}");
//   }
//   print("----------------------------------------------");
//   print("Total Amount: ₹$totalAmount");

//   // Display offers
//   print("\n---------------- Free Offers ------------------");
//   if (smallQty >= 4) {
//     print("Offer: Free 500ml Coke (for buying 4+ Small Pizzas)");
//   }
//   if (mediumQty >= 3) {
//     print("Offer: Free 1L Coke (for buying 3+ Medium Pizzas)");
//   }
//   if (largeQty >= 2) {
//     print("Offer: Free Ice + 500ml Coke (for buying 2+ Large Pizzas)");
//   }
//   if (monsterQty >= 1) {
//     print("Offer: Free 1L Coke + Ice Cream (for buying Monster Pizza)");
//   }
//   print("----------------------------------------------");
// }

import 'dart:io';

void main() {
  // Quantity counters
  int smallQty = 0;
  int mediumQty = 0;
  int largeQty = 0;
  int monsterQty = 0;

  String response = 'y';
  int totalAmount = 0;

  while (response.toLowerCase() == 'y') {
    print("-------------- Menu --------------");
    print("1. Small     - ₹150 per piece");
    print("2. Medium    - ₹250 per piece");
    print("3. Large     - ₹500 per piece");
    print("4. Monster   - ₹750 per piece");

    int choice = 0;
    while (choice < 1 || choice > 4) {
      stdout.write("Please enter a valid choice (1-4): ");
      choice = int.tryParse(stdin.readLineSync()!) ?? 0;
    }

    int price = 0;
    String itemName = '';
    switch (choice) {
      case 1:
        itemName = 'Small';
        price = 150;
        break;
      case 2:
        itemName = 'Medium';
        price = 250;
        break;
      case 3:
        itemName = 'Large';
        price = 500;
        break;
      case 4:
        itemName = 'Monster';
        price = 750;
        break;
    }

    stdout.write("Enter the quantity for $itemName: ");
    int qty = int.tryParse(stdin.readLineSync()!) ?? 0;

    int amount = price * qty;
    print("Amount: ₹$amount");

    totalAmount += amount;

    // Update quantity per item
    if (choice == 1) {
      smallQty += qty;
    } else if (choice == 2) {
      mediumQty += qty;
    } else if (choice == 3) {
      largeQty += qty;
    } else {
      monsterQty += qty;
    }

    stdout.write("Do you want to place more orders? (y/n): ");
    response = stdin.readLineSync() ?? 'n';
  }

  // Order summary
  print("\n---------------- Order Summary ----------------");
  print("Item      | Price | Quantity | Amount");
  print("----------------------------------------------");
  if (smallQty > 0) {
    print("Small     | 150   | $smallQty       | ${smallQty * 150}");
  }
  if (mediumQty > 0) {
    print("Medium    | 250   | $mediumQty       | ${mediumQty * 250}");
  }
  if (largeQty > 0) {
    print("Large     | 500   | $largeQty       | ${largeQty * 500}");
  }
  if (monsterQty > 0) {
    print("Monster   | 750   | $monsterQty       | ${monsterQty * 750}");
  }
  print("----------------------------------------------");
  print("Total Amount: ₹$totalAmount");

  // Calculate and display offers
  print("\n---------------- Free Offers ------------------");
  int smallOffers = smallQty ~/ 4;
  int mediumOffers = mediumQty ~/ 3;
  int largeOffers = largeQty ~/ 2;
  int monsterOffers = monsterQty;

  if (smallOffers > 0) {
    print("Offer: $smallOffers × 500ml Coke (for Small Pizza)");
  }
  if (mediumOffers > 0) {
    print("Offer: $mediumOffers × 1L Coke (for Medium Pizza)");
  }
  if (largeOffers > 0) {
    print("Offer: $largeOffers × Ice + 500ml Coke (for Large Pizza)");
  }
  if (monsterOffers > 0) {
    print("Offer: $monsterOffers × 1L Coke + Ice Cream (for Monster Pizza)");
  }
  if (smallOffers == 0 &&
      mediumOffers == 0 &&
      largeOffers == 0 &&
      monsterOffers == 0) {
    print("No free offers available.");
  }
  print("----------------------------------------------");
}
