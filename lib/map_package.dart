import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  final String location; // Facility's location as a string

  MapPage({required this.location});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double? latitude;
  double? longitude;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCoordinates();
  }

  Future<void> _fetchCoordinates() async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(widget.location)}&format=json&limit=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            latitude = double.parse(data[0]['lat']);
            longitude = double.parse(data[0]['lon']);
            isLoading = false;
          });
        } else {
          throw Exception('No results found for the location.');
        }
      } else {
        throw Exception('Failed to fetch coordinates.');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching coordinates
          : errorMessage != null
          ? Center(child: Text('Error: $errorMessage')) // Display error message if geocoding fails
          : FlutterMap(
        options: MapOptions(
          center: LatLng(latitude!, longitude!),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude!, longitude!),
                builder: (ctx) => Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
