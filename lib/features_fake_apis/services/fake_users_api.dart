import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<http.Response> fetchUsers(String url, {String method = 'GET', Map<String, dynamic>? body, Map<String, String>? headers}) async {
    if (method == 'GET') {
      return await http.get(Uri.parse(url));
    } else if (method == 'PUT') {
      return await http.put(
        Uri.parse(url),
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } else if (method == 'POST'){
      return await http.post(Uri.parse(url),
      headers: headers ?? {'Content=Type': 'application/json'}
      );
    } else{
      throw Exception('Unsupported HTTP method: $method');
    }
  }
}
