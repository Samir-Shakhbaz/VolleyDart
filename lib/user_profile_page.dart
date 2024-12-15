import 'dart:io';
import 'package:flutter/material.dart';
import 'user.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _skillLevelController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.user.bio;
    _skillLevelController.text = widget.user.skillLevel;
    _motivationController.text = widget.user.motivation;
    _heightController.text = widget.user.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Profile Picture
            widget.user.profilePicture != null
                ? CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(File(widget.user.profilePicture!)),
            )
                : const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),

            // Required Fields
            Text("Username: ${widget.user.username}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Email: ${widget.user.email}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Home City: ${widget.user.homeCity}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Gender: ${widget.user.gender}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // Optional Fields
            const Text(
              "Bio",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                hintText: "Tell us about yourself",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            const Text(
              "Skill Level",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _skillLevelController,
              decoration: const InputDecoration(
                hintText: "Enter your skill level (e.g., Beginner, Intermediate, Advanced)",
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Motivation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _motivationController,
              decoration: const InputDecoration(
                hintText: "What motivates you?",
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Height",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                hintText: "Enter your height (e.g., 5'9\" or 1.75m)",
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.user.bio = _bioController.text;
                  widget.user.skillLevel = _skillLevelController.text;
                  widget.user.motivation = _motivationController.text;
                  widget.user.height = _heightController.text;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated successfully!")),
                );
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
