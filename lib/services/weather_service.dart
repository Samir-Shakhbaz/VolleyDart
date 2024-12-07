import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = "https://goweather.herokuapp.com";

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/weather/$city'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch weather data");
    }
  }
}
