import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'services/geo_location_service.dart'; // Import GeoService

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GeoService _geoService = GeoService();
  Map<String, dynamic>? _locationData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _fetchLocation() async {
    try {
      final data = await _geoService.fetchLocation();
      setState(() {
        _locationData = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Forces external browser
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Location Display
            if (_locationData != null) ...[
              Text(
                "Location: ${_locationData!['city']}, ${_locationData!['country']}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ] else if (_error != null) ...[
              Text(
                "Error fetching location: $_error",
                style: TextStyle(color: Colors.red),
              ),
            ] else ...[
              CircularProgressIndicator(),
            ],
            SizedBox(height: 20),
            // Register Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Login'),
            ),
            // Test Google Link Button
            ElevatedButton(
              onPressed: () {
                _launchURL("https://www.google.com");
              },
              child: const Text('Test Google Link'),
            ),
          ],
        ),
      ),
    );
  }
}
