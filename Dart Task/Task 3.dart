import 'dart:io';

void main() {
  int burgerQty = 0;
  int dosaQty = 0;
  int idliQty = 0;

  int smallPizzaQty = 0;
  int mediumPizzaQty = 0;
  int largePizzaQty = 0;
  int monsterPizzaQty = 0;

  int totalAmount = 0;
  String response = 'y';

  while (response.toLowerCase() == 'y') {
    print("\n-------------- Main Menu --------------");
    print("1. Pizza");
    print("2. Burger - ₹100/pc");
    print("3. Dosa   - ₹120/pc");
    print("4. Idli   - ₹50/pc");

    int choice = 0;
    while (choice < 1 || choice > 4) {
      stdout.write("Please enter your choice (1-4): ");
      choice = int.tryParse(stdin.readLineSync()!) ?? 0;
    }

    if (choice == 1) {
      // Pizza Size Menu
      print("\n------ Pizza Size Menu ------");
      print("1. Small    - ₹150");
      print("2. Medium   - ₹250");
      print("3. Large    - ₹500");
      print("4. Monster  - ₹750");

      int pizzaChoice = 0;
      while (pizzaChoice < 1 || pizzaChoice > 4) {
        stdout.write("Select pizza size (1-4): ");
        pizzaChoice = int.tryParse(stdin.readLineSync()!) ?? 0;
      }

      int price = 0;
      String pizzaSize = '';
      switch (pizzaChoice) {
        case 1:
          pizzaSize = 'Small';
          price = 150;
          break;
        case 2:
          pizzaSize = 'Medium';
          price = 250;
          break;
        case 3:
          pizzaSize = 'Large';
          price = 500;
          break;
        case 4:
          pizzaSize = 'Monster';
          price = 750;
          break;
      }

      stdout.write("Enter quantity for $pizzaSize Pizza: ");
      int qty = int.tryParse(stdin.readLineSync()!) ?? 0;
      int amount = price * qty;
      totalAmount += amount;
      print("Added ₹$amount for $qty × $pizzaSize Pizza");

      // Update quantity
      if (pizzaChoice == 1) smallPizzaQty += qty;
      if (pizzaChoice == 2) mediumPizzaQty += qty;
      if (pizzaChoice == 3) largePizzaQty += qty;
      if (pizzaChoice == 4) monsterPizzaQty += qty;
    } else {
      int price = 0;
      String itemName = '';
      switch (choice) {
        case 2:
          itemName = 'Burger';
          price = 100;
          break;
        case 3:
          itemName = 'Dosa';
          price = 120;
          break;
        case 4:
          itemName = 'Idli';
          price = 50;
          break;
      }

      stdout.write("Enter quantity for $itemName: ");
      int qty = int.tryParse(stdin.readLineSync()!) ?? 0;
      int amount = price * qty;
      totalAmount += amount;
      print("Added ₹$amount for $qty × $itemName");

      // Update quantity
      if (choice == 2) burgerQty += qty;
      if (choice == 3) dosaQty += qty;
      if (choice == 4) idliQty += qty;
    }

    stdout.write("Do you want to order more? (y/n): ");
    response = stdin.readLineSync() ?? 'n';
  }

  // Order Summary
  print("\n================= ORDER SUMMARY =================");
  print("Item           | Price | Qty | Amount");
  print("-----------------------------------------------");
  if (smallPizzaQty > 0) {
    print("Small Pizza    |  150  | $smallPizzaQty   | ${smallPizzaQty * 150}");
  }
  if (mediumPizzaQty > 0) {
    print(
      "Medium Pizza   |  250  | $mediumPizzaQty   | ${mediumPizzaQty * 250}",
    );
  }
  if (largePizzaQty > 0) {
    print("Large Pizza    |  500  | $largePizzaQty   | ${largePizzaQty * 500}");
  }
  if (monsterPizzaQty > 0) {
    print(
      "Monster Pizza  |  750  | $monsterPizzaQty   | ${monsterPizzaQty * 750}",
    );
  }
  if (burgerQty > 0) {
    print("Burger         |  100  | $burgerQty   | ${burgerQty * 100}");
  }
  if (dosaQty > 0) {
    print("Dosa           |  120  | $dosaQty   | ${dosaQty * 120}");
  }
  if (idliQty > 0) {
    print("Idli           |   50  | $idliQty   | ${idliQty * 50}");
  }
  print("-----------------------------------------------");
  print("Total Amount: ₹$totalAmount");

  // Offers
  print("\n---------------- Free Offers ----------------");
  if (smallPizzaQty >= 4) {
    print("✅ ${smallPizzaQty ~/ 4} × 500ml Coke (Small Pizza)");
  }
  if (mediumPizzaQty >= 3) {
    print("✅ ${mediumPizzaQty ~/ 3} × 1L Coke (Medium Pizza)");
  }
  if (largePizzaQty >= 2) {
    print("✅ ${largePizzaQty ~/ 2} × Ice + 500ml Coke (Large Pizza)");
  }
  if (monsterPizzaQty >= 1) {
    print("✅ $monsterPizzaQty × 1L Coke + Ice Cream (Monster Pizza)");
  }
  if (smallPizzaQty < 4 &&
      mediumPizzaQty < 3 &&
      largePizzaQty < 2 &&
      monsterPizzaQty < 1) {
    print("No free offers available.");
  }
  print("-----------------------------------------------");
}
