import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'create_event.dart';
import 'display_events.dart';
import 'facilities.dart';
import 'global_events.dart';
import 'weather_page.dart';
import 'chat_page.dart';
import 'user_dashboard.dart';

class AuthenticatedPage extends StatelessWidget {
  final String username; // Receive the username from LoginPage

  const AuthenticatedPage({Key? key, required this.username}) : super(key: key);

  // Function to open the website
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticated Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
              child: const Text('Weather'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: const Text('Chat'),
            ),
            const SizedBox(height: 16),
            // Add website button
            ElevatedButton(
              onPressed: () {
                _launchURL('https://example.com'); // Replace with your desired URL
              },
              child: const Text('Visit Website'),
            ),
          ],
        ),
      ),
    );
  }
}
