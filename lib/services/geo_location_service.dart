import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoService {
  Future<Map<String, dynamic>> fetchLocation() async {
    final url = Uri.parse("https://get.geojs.io/v1/ip/geo.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch geolocation data");
    }
  }
}
