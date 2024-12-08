import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'user_storage.dart';
import 'user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _skillLevelController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _homeCityController = TextEditingController();

  String? _selectedMotivation;
  String? _selectedGender;

  File? _selectedImage; // To store the selected profile picture
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
                "User Registration",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Profile Picture
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : null,
                    child: _selectedImage == null
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a username";
                  }
                  return null;
                },
              ),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an email";
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
                    return "Please enter a password";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Player Profile
              const Text(
                "Player Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Bio
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: "Tell us about yourself"),
                maxLines: 3,
              ),

              // Skill Level
              TextFormField(
                controller: _skillLevelController,
                decoration: const InputDecoration(labelText: "Skill Level (1-10)"),
                keyboardType: TextInputType.number,
              ),

              // Motivation
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Motivation"),
                items: const [
                  DropdownMenuItem(value: "Recreational", child: Text("Recreational")),
                  DropdownMenuItem(value: "Competitive", child: Text("Competitive")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedMotivation = value;
                  });
                },
              ),

              // Height
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: "Height (meters or feet)"),
                keyboardType: TextInputType.number,
              ),

              // Home City
              TextFormField(
                controller: _homeCityController,
                decoration: const InputDecoration(labelText: "Home City"),
              ),

              // Gender
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Gender"),
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a new User
                    final newUser = User(
                      username: _usernameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      bio: _bioController.text.isNotEmpty ? _bioController.text : "No bio provided",
                      skillLevel: _skillLevelController.text,
                      motivation: _selectedMotivation ?? "Recreational",
                      height: _heightController.text,
                      homeCity: _homeCityController.text,
                      gender: _selectedGender ?? "Other",
                      profilePicture: _selectedImage?.path, // Save the image path
                    );

                    // Add the user to storage
                    UserStorage.addUser(newUser);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration successful!")),
                    );

                    // Navigate back to the Home Page
                    Navigator.pop(context);
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
