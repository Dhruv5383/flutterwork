// Implement a mock weather fetching program. Display different messages as it waits for a response and then shows a message like “Weather data loaded successfully.”

import 'dart:async';

void main() async {
  print("Connecting to weather service...");

  await Future.delayed(Duration(seconds: 1));
  print("Fetching weather data...");

  await Future.delayed(Duration(seconds: 2));
  print("Processing data...");

  await Future.delayed(Duration(seconds: 1));
  print("\n✅ Weather data loaded successfully!");
  print("🌤️ Temperature: 28°C");
  print("💧 Humidity: 60%");
  print("🌬️ Wind: 12 km/h");
}
