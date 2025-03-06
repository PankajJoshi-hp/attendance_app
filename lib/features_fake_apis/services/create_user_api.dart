import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateUserApi {
  final String apiUrl = 'https://api.escuelajs.co/api/v1/users/';

  Future<Map<String, dynamic>?> createUser(
      Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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
