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
            subtitle: Text(
                "${event["location"]!} - Surface: ${event["surface"]!} - Team Size: ${event["teamSize"]!} - Skill Level: ${event["skillLevel"]!} - Gender: ${event["gender"]!}"),
          );
        },
      ),
    );
  }
}
