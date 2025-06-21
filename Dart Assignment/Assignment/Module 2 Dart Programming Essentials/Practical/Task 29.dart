// Write a program that uses the spread operator to combine multiple lists into one list. Remove duplicates and sort the list in ascending order.

void main() {
  // Define multiple lists
  List<int> list1 = [5, 3, 8, 1];
  List<int> list2 = [2, 8, 3, 7];
  List<int> list3 = [4, 1, 6, 5];

  // Combine lists using the spread operator
  List<int> combinedList = [...list1, ...list2, ...list3];

  // Remove duplicates by converting to a Set and back to a List
  List<int> uniqueList = combinedList.toSet().toList();

  // Sort the list in ascending order
  uniqueList.sort();

  // Display the result
  print('Combined, unique, and sorted list: $uniqueList');
}
