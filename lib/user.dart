class User {
  final String username;
  final String email;
  final String password;
  final String bio;
  final String skillLevel;
  final String motivation;
  final String height;
  final String homeCity;
  final String gender;
  final String? profilePicture; //OPTIONAL

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.bio,
    required this.skillLevel,
    required this.motivation,
    required this.height,
    required this.homeCity,
    required this.gender,
    this.profilePicture,
  });
}

// Global list to store users temporarily
List<User> registeredUsers = [];
