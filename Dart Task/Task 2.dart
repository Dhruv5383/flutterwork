import 'dart:io';

void main() {
  int pizzaQty = 0;
  int burgerQty = 0;
  int dosaQty = 0;
  int idliQty = 0;
  String response = 'y';
  int totalAmount = 0;

  while (response == 'y') {
    print("--------------Menu--------------");
    print("1. Pizza\tprice = 180rs/pc");
    print("2. Burger\tprice = 100rs/pc");
    print("3. Dosa\t\tprice = 120rs/pc");
    print("4. Idli\t\tprice = 50rs/pc");

    int choice = 0;
    do {
      stdout.write("Please enter a valid choice (1-4): ");
      choice = int.tryParse(stdin.readLineSync()!) ?? 0;
    } while (choice < 1 || choice > 4);

    int price = 0;
    switch (choice) {
      case 1:
        print("You have selected Pizza");
        price = 180;
        break;
      case 2:
        print("You have selected Burger");
        price = 100;
        break;
      case 3:
        print("You have selected Dosa");
        price = 120;
        break;
      case 4:
        print("You have selected Idli");
        price = 50;
        break;
    }

    stdout.write("Enter the quantity: ");
    int qty = int.tryParse(stdin.readLineSync()!) ?? 0;

    int amount = price * qty;
    print("Amount: ₹$amount");
    totalAmount += amount;
    print("Total amount so far: ₹$totalAmount");

    // Update quantity per item
    if (choice == 1) {
      pizzaQty += qty;
    } else if (choice == 2) {
      burgerQty += qty;
    } else if (choice == 3) {
      dosaQty += qty;
    } else {
      idliQty += qty;
    }

    // Ask if user wants to order more
    do {
      stdout.write("Do you want to place more orders? (y/n): ");
      response = stdin.readLineSync()!.toLowerCase();
    } while (response != 'y' && response != 'n');
  }

  // Final Order Summary
  print("\n---------------------Order Summary--------------------");
  print("Item\t\tPrice\tQuantity\tAmount");

  if (pizzaQty != 0) {
    print("Pizza\t\t180\t$pizzaQty\t\t${pizzaQty * 180}");
  }
  if (burgerQty != 0) {
    print("Burger\t\t100\t$burgerQty\t\t${burgerQty * 100}");
  }
  if (dosaQty != 0) {
    print("Dosa\t\t120\t$dosaQty\t\t${dosaQty * 120}");
  }
  if (idliQty != 0) {
    print("Idli\t\t50\t$idliQty\t\t${idliQty * 50}");
  }

  print("------------------------------------------------------");
  print("Total Amount:\t\t\t\t₹$totalAmount");
}
