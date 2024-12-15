import 'dart:io';

import 'package:flutter/material.dart';
import 'availability_page.dart'; // Import AvailabilityPage

class UserDashboard extends StatelessWidget {
  final String username;
  final String email;
  final List<String> locations;
  final List<String> facilities;
  final List<String> eventNames;
  final List<Map<String, dynamic>> events;
  final String? profilePicture;

  const UserDashboard({
    Key? key,
    required this.username,
    required this.email,
    required this.locations,
    required this.facilities,
    required this.eventNames,
    required this.events,
    this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profilePicture != null && profilePicture!.isNotEmpty
                    ? FileImage(File(profilePicture!))
                    : null,
                child: profilePicture == null || profilePicture!.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 10),

            // Welcome Section
            Text(
              "Welcome, $username!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text("Email: $email"),
            const Divider(),

            // "Set Availability" Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvailabilityPage(events: events),
                  ),
                );
              },
              child: const Text("Set Availability"),
            ),
            const Divider(),

            // Profile Section
            const Text(
              "Your Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text("Skill Level: 5"), // Placeholder
            Text("Motivation: High"), // Placeholder
            const Divider(),

            // Simple Search Section
            const Text(
              "Simple Search",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Search by Location"),
              items: locations.map((location) {
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
              onChanged: (value) {
                // Handle simple search
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Trigger simple search
              },
              child: const Text("Search"),
            ),
            const Divider(),

            // Advanced Search Section
            const Text(
              "Advanced Search",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Location"),
              items: locations.map((location) {
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
              onChanged: (value) {
                // Handle location selection
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Skill Level",
                hintText: "1-13",
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Facility"),
              items: facilities.map((facility) {
                return DropdownMenuItem(value: facility, child: Text(facility));
              }).toList(),
              onChanged: (value) {
                // Handle facility selection
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Date"),
              keyboardType: TextInputType.datetime,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Gender"),
              items: ["Male", "Female", "Other"].map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender));
              }).toList(),
              onChanged: (value) {
                // Handle gender selection
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Event Name"),
              items: eventNames.map((event) {
                return DropdownMenuItem(value: event, child: Text(event));
              }).toList(),
              onChanged: (value) {
                // Handle event name selection
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Team Size",
                hintText: "Enter Team Size",
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger advanced search
                  },
                  child: const Text("Search"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Reset advanced search fields
                  },
                  child: const Text("Reset"),
                ),
              ],
            ),
            const Divider(),

            // Events Section
            const Text(
              "Your Events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            events.isNotEmpty
                ? Column(
              children: events.map((event) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(event['name']),
                    subtitle: Text(
                        "${event['date']} at ${event['time']} - Location: ${event['location']} - Gender: ${event['genderFormat']} - Skill Level: ${event['skillLevel']}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle join event
                      },
                      child: const Text("Join"),
                    ),
                  ),
                );
              }).toList(),
            )
                : const Text("No events available."),
            const Divider(),

            // Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to HomePage
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
