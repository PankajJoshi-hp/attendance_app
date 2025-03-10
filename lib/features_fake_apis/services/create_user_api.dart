import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CreateUserApi {
  final String? apiUrl = dotenv.env['API_KEY_USERS'];

  Future<Map<String, dynamic>?> createUser(
      Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl!),
        body: jsonEncode(userData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }
}
