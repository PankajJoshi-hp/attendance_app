import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/main.dart';

class SignupController extends GetxController {
  final String apiUrl = 'https://energyeye.apinext.in/api/customerRegister';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> postData(context) async {
    print('*******************');
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': usernameController.text,
            'email': emailController.text,
            'phone': numberController.text,
            'password': passwordController.text,
            "accepted_terms": 1,
            "device_token": "xyz"
          }));
      print(response.body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        usernameController.clear();
        emailController.clear();
        numberController.clear();
        passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      result = 'Error: $e';
    }
  }
}
