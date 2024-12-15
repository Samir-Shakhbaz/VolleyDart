import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification setup
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher'); // App icon

  const InitializationSettings initializationSettings =
  InitializationSettings(android: androidSettings);

  await notificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(MaterialApp(
    home: HomePage(),
  ));
}
