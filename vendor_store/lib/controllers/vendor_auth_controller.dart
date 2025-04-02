import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendor_store/global_variable.dart';
import 'package:vendor_store/models/vendor.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_store/services/manage_http_response.dart';
import 'package:vendor_store/views/screens/authentication/main_vendor_screen.dart';

class VendorAuthController {
  Future<void> signUpVendor({
    required String fullName,
    required String email,
    required String password,
    required context,
  }) async {
    try {
      Vendor vendor = Vendor(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        role: '',
        password: password,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/vendor/signup"),
        body:
            vendor
                .toJson(), //Convert the Vendor user object to json for the request body
        headers: <String, String>{
          //Set the Headers for the request
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      //managehttp response to handle http response base on their status code
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainVendorScreen();
              },
            ),
            (route) => false,
          );
          showSnackBar(context, 'Vendor Account Created');
        },
      );
    } catch (e) {
      showSnackBar(context, '$e');
    }
  }
  //function to consume the backend vendor signin api

  Future<void> signInVendor({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/vendor/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          //Set the Headers for the request
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Logged in successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, '$e');
    }
  }
}
