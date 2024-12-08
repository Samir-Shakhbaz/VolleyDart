import 'package:flutter/material.dart';
import 'user_dashboard.dart';
import 'register.dart';
import 'login.dart';
import 'create_event.dart';
import 'display_events.dart';
import 'facilities.dart';
import 'global_events.dart';
import 'weather_page.dart';
import 'chat_page.dart'; // Import ChatPage

class HomePage extends StatelessWidget {
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
