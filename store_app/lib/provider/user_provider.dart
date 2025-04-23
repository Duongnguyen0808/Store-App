import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // khoi tao doi tuong nguoi dung
  // quan ly trang  thai nguoi dung
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
  // chinh xuat gia tri
  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }
void signOut(){
  state = null;
}
  
}
final userProvider = StateNotifierProvider<UserProvider, User?>(
    (ref) => UserProvider(),
  );