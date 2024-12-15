import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

class AvailabilityPage extends StatefulWidget {
  final List<Map<String, dynamic>> events;

  const AvailabilityPage({Key? key, required this.events}) : super(key: key);

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final Map<DateTime, List<String>> _availability = {};
  late FlutterLocalNotificationsPlugin notificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadAvailability(); // Load saved availability
  }

  void _initializeNotifications() {
    tz.initializeTimeZones();
    notificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _saveAvailability() async {
    final prefs = await SharedPreferences.getInstance();
    final availabilityJson = jsonEncode(
      _availability.map((date, times) => MapEntry(date.toIso8601String(), times)),
    );
    await prefs.setString('availability', availabilityJson);
  }

  Future<void> _loadAvailability() async {
    final prefs = await SharedPreferences.getInstance();
    final availabilityJson = prefs.getString('availability');
    if (availabilityJson != null) {
      final availabilityMap = jsonDecode(availabilityJson) as Map<String, dynamic>;
      setState(() {
        _availability.clear();
        availabilityMap.forEach((key, value) {
          _availability[DateTime.parse(key)] = List<String>.from(value);
        });
      });
    }
  }

  void _addAvailability(DateTime date, String time) {
    setState(() {
      if (_availability.containsKey(date)) {
        _availability[date]!.add(time);
      } else {
        _availability[date] = [time];
      }
    });
    _saveAvailability(); // Save updated availability
  }

  void _checkEventMatches() async {
    List<String> matchedEvents = [];

    for (var event in widget.events) {
      final eventDate = DateTime.parse(event['date']); // Event date
      final eventTime = event['time']; // Event time (e.g., "9:00 AM - 11:00 AM")

      if (_availability.containsKey(eventDate) &&
          _availability[eventDate]!.contains(eventTime)) {
        matchedEvents.add("${event['name']} on ${event['date']} at $eventTime");

        // Schedule notification
        await _scheduleNotification(event['name'], eventDate, eventTime);
      }
    }

    if (matchedEvents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No matching events found.")),
      );
    } else {
      _showMatchesDialog(matchedEvents);
    }
  }

  Future<void> _scheduleNotification(
      String eventName, DateTime eventDate, String eventTime) async {
    final startTime = eventTime.split('-').first.trim();
    final timeParts = startTime.split(' '); // e.g., "10:00 AM"
    final hourMinute = timeParts.first.split(':');
    final period = timeParts.last;

    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    if (period == "PM" && hour != 12) {
      hour += 12;
    } else if (period == "AM" && hour == 12) {
      hour = 0;
    }

    final localTimeZone = tz.local;
    final eventDateTime = tz.TZDateTime(
      localTimeZone,
      eventDate.year,
      eventDate.month,
      eventDate.day,
      hour,
      minute,
    );

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'event_reminders',
      'Event Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await notificationsPlugin.zonedSchedule(
      eventDateTime.millisecondsSinceEpoch ~/ 1000,
      "Upcoming Event!",
      "$eventName is scheduled at $startTime",
      eventDateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _showMatchesDialog(List<String> matchedEvents) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Matched Events"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: matchedEvents
                .map((event) => Text(event, style: const TextStyle(fontSize: 16)))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Availability"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _availability.length,
              itemBuilder: (context, index) {
                final date = _availability.keys.elementAt(index);
                final times = _availability[date]!;
                return ListTile(
                  title: Text(
                      "${date.toLocal().toString().split(' ')[0]}: ${times.join(', ')}"),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _checkEventMatches,
            child: const Text("Check Matching Events"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );

          if (selectedDate != null) {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              final formattedTime = selectedTime.format(context);
              _addAvailability(selectedDate, formattedTime);
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
