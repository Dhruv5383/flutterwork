// Create a simple address book using a map, where the keys are names and the values are phone numbers. Add, update, and remove entries based on user input.
import 'dart:io';

void main() {
  Map<String, String> addressBook = {};
  bool running = true;

  while (running) {
    print('\n=== Address Book ===');
    print('1. Add Contact');
    print('2. Update Contact');
    print('3. Remove Contact');
    print('4. View All Contacts');
    print('5. Exit');
    print('Enter your choice (1-5):');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addContact(addressBook);
        break;
      case '2':
        updateContact(addressBook);
        break;
      case '3':
        removeContact(addressBook);
        break;
      case '4':
        viewContacts(addressBook);
        break;
      case '5':
        running = false;
        print('Exiting Address Book...');
        break;
      default:
        print('Invalid choice! Please enter a number between 1 and 5.');
    }
  }
}

void addContact(Map<String, String> book) {
  print('Enter contact name:');
  String? name = stdin.readLineSync();
  print('Enter phone number:');
  String? number = stdin.readLineSync();

  if (name != null && number != null && name.isNotEmpty && number.isNotEmpty) {
    book[name] = number;
    print('Contact added successfully!');
  } else {
    print('Invalid input. Contact not added.');
  }
}

void updateContact(Map<String, String> book) {
  print('Enter contact name to update:');
  String? name = stdin.readLineSync();

  if (name != null && book.containsKey(name)) {
    print('Enter new phone number:');
    String? newNumber = stdin.readLineSync();
    if (newNumber != null && newNumber.isNotEmpty) {
      book[name] = newNumber;
      print('Contact updated successfully!');
    } else {
      print('Invalid phone number. Update cancelled.');
    }
  } else {
    print('Contact not found!');
  }
}

void removeContact(Map<String, String> book) {
  print('Enter contact name to remove:');
  String? name = stdin.readLineSync();

  if (name != null && book.containsKey(name)) {
    book.remove(name);
    print('Contact removed successfully!');
  } else {
    print('Contact not found!');
  }
}

void viewContacts(Map<String, String> book) {
  if (book.isEmpty) {
    print('Address book is empty!');
  } else {
    print('\n=== Contacts ===');
    book.forEach((name, number) {
      print('$name: $number');
    });
  }
}
