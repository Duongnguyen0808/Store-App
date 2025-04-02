import 'package:flutter/material.dart';
import 'package:store_app/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _authController.signOutUser(context: context);
          },
          child: Text('Signout'),
        ),
      ),
    );
  }
}
