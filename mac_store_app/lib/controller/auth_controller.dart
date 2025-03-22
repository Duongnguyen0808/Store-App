import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/models/user.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/services/manage_http_responses.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/main_screen.dart'; // Import file chứa biến `uri`

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'), // Gửi yêu cầu POST đến API đăng ký
        body:
            user.toJson(), // Chuyển đổi đối tượng `user` thành JSON để gửi lên server
        headers: <String, String>{
          "Content-Type":
              'application/json; charset=UTF-8', // Định dạng nội dung gửi là JSON
        },
      );
      // Gọi hàm xử lý phản hồi từ server
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(
            context,
            'Account has been Created for you',
          ); // Hiển thị thông báo thành công
        },
      );

      // Xử lý lỗi nếu có
    } catch (e) {
      print('Lỗi xảy ra: $e'); // In lỗi ra console để dễ debug
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Logged In');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
