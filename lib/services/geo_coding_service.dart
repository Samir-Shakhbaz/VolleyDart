import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoService {
  Future<Map<String, double>> getCoordinates(String address) async {
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$address&format=json&limit=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {
          'latitude': double.parse(data[0]['lat']),
          'longitude': double.parse(data[0]['lon']),
        };
      } else {
        throw Exception('No results found for the given address.');
      }
    } else {
      throw Exception('Failed to fetch coordinates.');
    }
  }
}
