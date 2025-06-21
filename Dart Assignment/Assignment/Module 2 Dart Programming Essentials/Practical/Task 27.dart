// Write a function that simulates fetching multiple data points (e.g., list of users) asynchronously. Use await and async keywords to wait for each "data point" to load, then display all the data once loaded.

import 'dart:async';

Future<void> main() async {
  print('Fetching user data...');
  List<Map<String, String>> users = await fetchAllUsers();
  displayUsers(users);
}

Future<List<Map<String, String>>> fetchAllUsers() async {
  // Simulate fetching 3 users with delays
  List<Map<String, String>> users = [];

  users.add(await fetchUser(1)); // Wait for first user
  users.add(await fetchUser(2)); // Then fetch second
  users.add(await fetchUser(3)); // Then fetch third

  return users;
}

Future<Map<String, String>> fetchUser(int id) async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 1));

  // Return mock user data
  return {
    'id': id.toString(),
    'name': 'User $id',
    'email': 'user$id@example.com',
  };
}

void displayUsers(List<Map<String, String>> users) {
  print('\nAll users fetched successfully!');
  print('---------------------------------');
  for (var user in users) {
    print('ID: ${user['id']}');
    print('Name: ${user['name']}');
    print('Email: ${user['email']}');
    print('---------------------------------');
  }
}
