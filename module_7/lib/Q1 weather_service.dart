import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Q1 weather_model.dart';
//import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = "YOUR_API_KEY_HERE";

  Future<WeatherModel> fetchWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}