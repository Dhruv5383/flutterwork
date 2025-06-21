// Define a BankAccount class with properties like account number, account holder, and balance. Add methods to deposit, withdraw, and check the balance. Ensure the withdraw method doesn’t allow overdrafts.
import 'dart:io';

class BankAccount {
  String accountNumber;
  String accountHolder;
  double balance;

  // Constructor
  BankAccount(this.accountNumber, this.accountHolder, [this.balance = 0.0]);

  // Deposit money
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('\n✅ \$$amount deposited successfully.');
    } else {
      print('\n❌ Deposit amount must be positive.');
    }
  }

  // Withdraw money (prevents overdraft)
  void withdraw(double amount) {
    if (amount > 0) {
      if (balance >= amount) {
        balance -= amount;
        print('\n✅ \$$amount withdrawn successfully.');
      } else {
        print('\n❌ Insufficient funds. Withdrawal denied.');
      }
    } else {
      print('\n❌ Withdrawal amount must be positive.');
    }
  }

  // Check balance
  void checkBalance() {
    print('\n-----------------------------');
    print('🏦 Account Holder: $accountHolder');
    print('🔢 Account Number: $accountNumber');
    print('💰 Current Balance: \$${balance.toStringAsFixed(2)}');
    print('-----------------------------');
  }
}

void main() {
  // Get user input for account creation
  stdout.write('Enter Account Holder Name: ');
  String holderName = stdin.readLineSync() ?? 'Guest';

  stdout.write('Enter Account Number: ');
  String accNumber = stdin.readLineSync() ?? '00000000';

  var account = BankAccount(accNumber, holderName);

  print('\n✔ Account created successfully for $holderName.');

  // Interactive banking loop
  while (true) {
    print('\n1. Deposit 💰');
    print('2. Withdraw 🏧');
    print('3. Check Balance 📊');
    print('4. Exit ❌');
    stdout.write('\nSelect an option (1-4): ');
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write('Enter the amount to deposit: ');
      double depositAmount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      account.deposit(depositAmount);
    } else if (choice == '2') {
      stdout.write('Enter the amount to withdraw: ');
      double withdrawAmount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      account.withdraw(withdrawAmount);
    } else if (choice == '3') {
      account.checkBalance();
    } else if (choice == '4') {
      print('🔴 Thank you for banking with us!');
      break;
    } else {
      print('🔴 Invalid option. Please try again.');
    }
  }
}
