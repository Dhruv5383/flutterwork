import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<bool> sendFeedback(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 201;
  }
}