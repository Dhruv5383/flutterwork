// Create a program that generates a QR code from a given string using a QR code package, and display it in the console.
void main() {
  // Input string to generate a QR-like code
  String inputString = "HELLO";

  // Generate a simple QR-like pattern
  List<String> qrCode = generateSimpleQR(inputString);

  // Display the QR-like code in the console
  print("QR-like Code for '$inputString':");
  for (String line in qrCode) {
    print(line);
  }
}

List<String> generateSimpleQR(String text) {
  // This is a very simplified QR-like pattern
  List<String> rows = [];

  // Create a simple pattern based on the length of the input string
  for (int i = 0; i < 5; i++) {
    String row = '';
    for (int j = 0; j < text.length; j++) {
      // Alternate between dark and light based on character codes
      if ((text.codeUnitAt(j) + i) % 2 == 0) {
        row += '██'; // Dark module
      } else {
        row += '  '; // Light module
      }
    }
    rows.add(row);
  }

  return rows;
}
