import 'user.dart';

class UserStorage {
  // Temporary in-memory user storage
  static final List<User> _registeredUsers = [
    User(
      username: "testUser",
      password: "1234",
      email: "test@example.com",
      bio: '',
      skillLevel: '',
      motivation: '',
      height: '',
      homeCity: '',
      gender: '',
      profilePicture: null, // No profile picture by default
    ),
    User(
      username: "johnDoe",
      password: "password",
      email: "john.doe@example.com",
      bio: '',
      skillLevel: '',
      motivation: '',
      height: '',
      homeCity: '',
      gender: '',
      profilePicture: null, // No profile picture by default
    ),
  ];

  // Function to add a new user
  static void addUser(User user) {
    _registeredUsers.add(user);
  }

  // Function to find a user by username and password
  static User? findUser(String username, String password) {
    try {
      return _registeredUsers.firstWhere(
            (user) => user.username == username && user.password == password,
      );
    } catch (e) {
      return null; // Return null if user is not found
    }
  }

  // Function to list all registered users (for debugging or display purposes)
  static List<User> getAllUsers() {
    return _registeredUsers;
  }
}
