import 'package:flutter/material.dart';
import 'user_storage.dart';
import 'user.dart';
import 'user_dashboard.dart';
import 'package:volley_app/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Initialize the AuthService
  final AuthService authService = AuthService('http://10.0.2.2:8080');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "User Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // AuthService validation
                      final isLoggedIn = await authService.login(
                        _usernameController.text,
                        _passwordController.text,
                      );

                      if (isLoggedIn) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login successful!")),
                        );

                        // Navigate to the dashboard
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDashboard(
                              username: _usernameController.text,
                              email: "user@example.com", // Replace with actual email
                              locations: ["Location1", "Location2"],
                              facilities: ["Facility1", "Facility2"],
                              eventNames: ["Event1", "Event2"],
                              events: [],
                              profilePicture: "", // Replace with actual profile picture if available
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid username or password")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }

                    // Uncomment for local UserStorage validation:
                    /*
                    // Validate user credentials using UserStorage
                    final user = UserStorage.findUser(
                      _usernameController.text,
                      _passwordController.text,
                    );

                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login successful!")),
                      );

                      // Navigate to the dashboard
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDashboard(
                            username: user.username,
                            email: user.email,
                            locations: ["Location1", "Location2"],
                            facilities: ["Facility1", "Facility2"],
                            eventNames: ["Event1", "Event2"],
                            events: [],
                            profilePicture: user.profilePicture, // Pass profile picture
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid username or password")),
                      );
                    }
                    */
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
