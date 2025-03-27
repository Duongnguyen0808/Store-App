import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store_app/global_variables.dart';
import 'package:store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/services/manage_http_response.dart';
import 'package:store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUser({
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
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body:
            user.toJson(), //Convert the user Object to Json for the request body
        headers: <String, String>{
          //Set the Headers for the request
          "Content-Type":
              'application/json; charset=UTF-8', //specify the context type as Json
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(context, 'Account has been Created for you ');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //signin users function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email, //include the email in the request body,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //handle response using the managehttpResponse

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Logged In ');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
