import 'package:flutter/material.dart';
import 'services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      setState(() {
        _errorMessage = "City name cannot be empty";
      });
      return;
    }

    try {
      final data = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = data;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _weatherData = null;
        _errorMessage = "Failed to fetch weather data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter city",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text("Get Weather"),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            if (_weatherData != null) ...[
              Text("Weather for ${_weatherData!['city'] ?? 'Unknown'}"),
              Text("Temperature: ${_weatherData!['temperature'] ?? 'N/A'}"),
              Text("Description: ${_weatherData!['description'] ?? 'N/A'}"),
            ],
          ],
        ),
      ),
    );
  }
}
