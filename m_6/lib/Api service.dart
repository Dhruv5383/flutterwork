// lib/services/api_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import '../models/service_provider.dart';
//import '../utils/constants.dart';
import 'Constants.dart';
import 'Service provider.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<List<ServiceProvider>> fetchServiceProviders() async {
    try {
      final response = await http
          .get(Uri.parse(AppStrings.mockApiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceProvider.fromJson(json)).toList();
      } else {
        debugPrint('API error: ${response.statusCode}');
        return _getMockProviders();
      }
    } catch (e) {
      debugPrint('Fetch error, using mock data: $e');
      return _getMockProviders();
    }
  }

  List<ServiceProvider> _getMockProviders() {
    return MockData.services
        .map((json) => ServiceProvider.fromJson(json))
        .toList();
  }
}