import 'dart:convert';
import 'dart:io';

class LocalStorage {
  static const String _filePath = 'users.json';

  // Save a user to the local file
  static Future<void> saveUser(Map<String, String> user) async {
    final file = File(_filePath);

    List<Map<String, String>> users = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      users = List<Map<String, String>>.from(jsonDecode(content));
    }

    users.add(user);
    await file.writeAsString(jsonEncode(users));
  }

  // Fetch all users from the local file
  static Future<List<Map<String, String>>> getUsers() async {
    final file = File(_filePath);

    if (!await file.exists()) {
      return [];
    }

    final content = await file.readAsString();
    return List<Map<String, String>>.from(jsonDecode(content));
  }
}
