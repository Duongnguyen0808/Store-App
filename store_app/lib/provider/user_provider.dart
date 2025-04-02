import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // contructore initializing with default User Object
  // purpose: Manage the state of the user object allowing updates
  UserProvider()
    : super(
        User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ),
      );

  // Getter method to extract value from an object
  User? get user => state;
  // Method to get user state from Json
  // purpose: updates he user state base on json String representation of user Object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }
}

// Make the data accessible within the application
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
