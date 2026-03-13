import 'package:flutter/material.dart';
import 'Q1 weather_model.dart';
import 'Q1 weather_service.dart';
//import 'services/weather_service.dart';
//import 'models/weather_model.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  final TextEditingController controller = TextEditingController();

  WeatherModel? weather;
  bool isLoading = false;

  void getWeather() async {
    setState(() => isLoading = true);

    try {
      final result = await weatherService.fetchWeather(controller.text);
      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("City not found")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter city name",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: getWeather,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (isLoading) const CircularProgressIndicator(),

            if (weather != null) ...[
              Text(
                weather!.cityName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Image.network(
                "https://openweathermap.org/img/wn/${weather!.icon}@2x.png",
              ),
              Text(
                "${weather!.temperature} °C",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                weather!.description,
                style: const TextStyle(fontSize: 18),
              ),
            ]
          ],
        ),
      ),
    );
  }
}