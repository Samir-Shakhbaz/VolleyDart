import 'package:flutter/material.dart';
import 'user_dashboard.dart';
import 'register.dart';
import 'login.dart';
import 'create_event.dart';
import 'display_events.dart';
import 'facilities.dart';
import 'global_events.dart';
import 'weather_page.dart';
import 'chat_page.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDashboard(
                      username: 'SampleUser',
                      email: 'sampleuser@example.com',
                      locations: ['Location1', 'Location2'],
                      facilities: ['Facility1', 'Facility2'],
                      eventNames: ['Event1', 'Event2'],
                      events: [],
                    ),
                  ),
                );
              },
              child: const Text('Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEventPage(),
                  ),
                );
              },
              child: const Text('Create Event'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayEventsPage(initialEvents: globalEvents),
                  ),
                );
              },
              child: const Text('Display Events'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FacilitiesPage()),
                );
              },
              child: const Text('Facilities'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()), // Navigate to WeatherPage
                );
              },
              child: const Text('Weather'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()), // Navigate to ChatPage
                );
              },
              child: const Text('Chat'), // Add Chat Button
            ),
          ],
        ),
      ),
    );
  }
}
