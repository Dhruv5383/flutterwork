//Create a simple grading system that takes a student’s score as input and prints their grade:
//• A: 90–100
//• B: 80–89
//• C: 70–79
//• D: 60–69
//• F: Below 60

import 'dart:io';

void main() {
  // Prompt the user to enter the student's score
  print('Enter the student\'s score (0-100):');
  String? input = stdin.readLineSync();

  // Check if the input is not null and can be parsed to an integer
  if (input != null) {
    int score = int.parse(input);

    // Determine the grade based on the score
    String grade;
    if (score >= 90 && score <= 100) {
      grade = 'A';
    } else if (score >= 80 && score < 90) {
      grade = 'B';
    } else if (score >= 70 && score < 80) {
      grade = 'C';
    } else if (score >= 60 && score < 70) {
      grade = 'D';
    } else if (score < 60 && score >= 0) {
      grade = 'F';
    } else {
      print('Invalid score. Please enter a score between 0 and 100.');
      return;
    }

    // Print the grade
    print('The student\'s grade is: $grade');
  } else {
    print('Invalid input. Please enter a valid score.');
  }
}
