import 'package:http/http.dart' as http;

class AuthService {
  final String backendUrl;

  AuthService(this.backendUrl);

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$backendUrl/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      print('Login successful!');
      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$backendUrl/register'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      print('Registration successful!');
      return true;
    } else {
      print('Registration failed: ${response.body}');
      return false;
    }
  }
}
