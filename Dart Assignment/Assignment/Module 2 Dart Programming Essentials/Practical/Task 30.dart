// Create a function that uses higher-order functions. Define a List of numbers and pass it to a function that returns a list of squares, cubes, or halves based on the function passed as an argument.

void main() {
  // Original list of numbers
  List<int> numbers = [2, 4, 6, 8, 10];

  // Define functions for square, cube, and half
  int square(int n) => n * n;
  int cube(int n) => n * n * n;
  double half(int n) => n / 2;

  // Call the higher-order function
  print("Squares: ${transformList(numbers, square)}");
  print("Cubes: ${transformList(numbers, cube)}");
  print("Halves: ${transformList(numbers, half)}");
}

// Higher-order function
List<dynamic> transformList(List<int> list, dynamic Function(int) operation) {
  return list.map(operation).toList();
}
