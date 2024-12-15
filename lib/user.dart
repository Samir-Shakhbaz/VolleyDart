class User {
  final String username;
  final String email;
  final String password;
  late final String bio; // Optional, default to "No bio provided"
  late final String skillLevel; // Optional, default to "Beginner"
  late final String motivation; // Optional, default to "Not specified"
  late final String height; // Optional, default to "Not specified"
  final String homeCity;
  final String gender;
  final String? profilePicture; // Optional

  User({
    required this.username,
    required this.email,
    required this.password,
    this.bio = "No bio provided",
    this.skillLevel = "Beginner",
    this.motivation = "Not specified",
    this.height = "Not specified",
    required this.homeCity,
    required this.gender,
    this.profilePicture,
  });
}

// Global list to store users temporarily
List<User> registeredUsers = [];
