// Create a program that fetches data from a fake API endpoint (using the http package). Display the data after it's loaded and catch any errors if the request fails.

import 'dart:async';

void main() async {
  print("Fetching data from fake API...");

  try {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulated fake API response
    Map<String, dynamic> fakeData = {
      'userId': 1,
      'id': 1,
      'title': 'Fake API Post Title',
      'body': 'This is the body of a fake API post.',
    };

    print("\n--- Data Fetched ---");
    print("Title: ${fakeData['title']}");
    print("Body : ${fakeData['body']}");
  } catch (e) {
    print("Error fetching data: $e");
  }
}
