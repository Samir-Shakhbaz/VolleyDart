import 'package:flutter/material.dart';

class DisplayEventsPage extends StatelessWidget {
  final List<Map<String, String>> initialEvents;

  const DisplayEventsPage({Key? key, required this.initialEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Events'),
      ),
      body: ListView.builder(
        itemCount: initialEvents.length,
        itemBuilder: (context, index) {
          final event = initialEvents[index];
          return ListTile(
            title: Text(event["name"]!),
            subtitle: Text("${event["location"]!} - Surface: ${event["surface"]!}"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(event: event),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event["name"] ?? "Event Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display event image if available
            event["image"] != null && event["image"]!.isNotEmpty
                ? Image.network(
              event["image"]!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Event details
            Text(
              "Name: ${event["name"]}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Location: ${event["location"]}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Surface: ${event["surface"]}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Team Size: ${event["teamSize"] ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Skill Level: ${event["skillLevel"] ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Gender: ${event["gender"] ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // Placeholder for additional features
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Feature coming soon!")),
                );
              },
              child: const Text("Join Event"),
            ),
          ],
        ),
      ),
    );
  }
}
