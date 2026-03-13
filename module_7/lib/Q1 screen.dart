// final code
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;


// void main() {
//   runApp(const WeatherLensApp());
// }
//
// class WeatherLensApp extends StatelessWidget {
//   const WeatherLensApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Weather Lens",
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF7A59)),
//         useMaterial3: true,
//         fontFamily: "SpaceGrotesk",
//       ),
//       home: const WeatherHome(),
//     );
//   }
// }

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();

  bool _loading = false;
  String _status = "Type a city and press Search.";
  WeatherResult? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    final query = _controller.text.trim();
    if (query.isEmpty) {
      setState(() {
        _status = "Enter a city name to search.";
        _result = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _status = "Looking up location...";
      _result = null;
    });

    try {
      final city = await _fetchCity(query);
      setState(() {
        _status = "Fetching live conditions...";
      });

      final weather = await _fetchCurrentWeather(city.latitude, city.longitude);
      setState(() {
        _result = WeatherResult(city: city, weather: weather);
        _status = "Showing live conditions.";
      });
    } catch (error) {
      setState(() {
        _status = error.toString().replaceFirst("Exception: ", "");
        _result = null;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<CityResult> _fetchCity(String query) async {
    final uri = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search"
          "?name=${Uri.encodeComponent(query)}&count=1&language=en&format=json",
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch city data.");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data["results"] as List<dynamic>?;
    if (results == null || results.isEmpty) {
      throw Exception("No matching city found.");
    }

    final item = results.first as Map<String, dynamic>;
    return CityResult(
      name: item["name"] as String,
      admin1: item["admin1"] as String?,
      country: item["country"] as String?,
      latitude: (item["latitude"] as num).toDouble(),
      longitude: (item["longitude"] as num).toDouble(),
    );
  }

  Future<WeatherCurrent> _fetchCurrentWeather(double lat, double lon) async {
    final uri = Uri.parse(
      "https://api.open-meteo.com/v1/forecast"
          "?latitude=$lat&longitude=$lon"
          "&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code"
          "&timezone=auto",
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch weather data.");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final current = data["current"] as Map<String, dynamic>;
    final units = data["current_units"] as Map<String, dynamic>;

    return WeatherCurrent(
      temperature: (current["temperature_2m"] as num).toDouble(),
      feelsLike: (current["apparent_temperature"] as num).toDouble(),
      humidity: (current["relative_humidity_2m"] as num).toDouble(),
      windSpeed: (current["wind_speed_10m"] as num).toDouble(),
      weatherCode: current["weather_code"] as int,
      time: current["time"] as String,
      tempUnit: units["temperature_2m"] as String,
      feelsUnit: units["apparent_temperature"] as String,
      humidityUnit: units["relative_humidity_2m"] as String,
      windUnit: units["wind_speed_10m"] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = _result;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1EA),
      appBar: AppBar(
        title: const Text("Weather Lens"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search any city to get a clean, real-time snapshot.",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Try: Bengaluru, Sao Paulo, Tokyo",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _fetchWeather(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _loading ? null : _fetchWeather,
                  child: _loading
                      ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text("Search"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _status,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 20),
            if (result != null) _WeatherCard(result: result),
          ],
        ),
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({required this.result});

  final WeatherResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final city = result.city;
    final weather = result.weather;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${city.admin1 ?? ""}${city.country != null ? ", ${city.country}" : ""}",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _MetricTile(label: "Temperature", value: weather.tempLabel),
              _MetricTile(label: "Feels like", value: weather.feelsLabel),
              _MetricTile(label: "Humidity", value: weather.humidityLabel),
              _MetricTile(label: "Wind", value: weather.windLabel),
              _MetricTile(label: "Conditions", value: weather.conditionLabel),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Updated at ${weather.time}",
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherResult {
  WeatherResult({required this.city, required this.weather});

  final CityResult city;
  final WeatherCurrent weather;
}

class CityResult {
  CityResult({
    required this.name,
    required this.admin1,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String? admin1;
  final String? country;
  final double latitude;
  final double longitude;
}

class WeatherCurrent {
  WeatherCurrent({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.time,
    required this.tempUnit,
    required this.feelsUnit,
    required this.humidityUnit,
    required this.windUnit,
  });

  final double temperature;
  final double feelsLike;
  final double humidity;
  final double windSpeed;
  final int weatherCode;
  final String time;
  final String tempUnit;
  final String feelsUnit;
  final String humidityUnit;
  final String windUnit;

  String get tempLabel => "${temperature.round()}$tempUnit";
  String get feelsLabel => "${feelsLike.round()}$feelsUnit";
  String get humidityLabel => "${humidity.round()}$humidityUnit";
  String get windLabel => "${windSpeed.toStringAsFixed(1)}$windUnit";
  String get conditionLabel => weatherCodeLabels[weatherCode] ?? "Unknown";
}

const Map<int, String> weatherCodeLabels = {
  0: "Clear sky",
  1: "Mainly clear",
  2: "Partly cloudy",
  3: "Overcast",
  45: "Fog",
  48: "Rime fog",
  51: "Light drizzle",
  53: "Moderate drizzle",
  55: "Dense drizzle",
  56: "Freezing drizzle",
  57: "Dense freezing drizzle",
  61: "Slight rain",
  63: "Moderate rain",
  65: "Heavy rain",
  66: "Freezing rain",
  67: "Heavy freezing rain",
  71: "Slight snow",
  73: "Moderate snow",
  75: "Heavy snow",
  77: "Snow grains",
  80: "Slight rain showers",
  81: "Moderate rain showers",
  82: "Violent rain showers",
  85: "Slight snow showers",
  86: "Heavy snow showers",
  95: "Thunderstorm",
  96: "Thunderstorm with hail",
  99: "Thunderstorm with heavy hail",
};