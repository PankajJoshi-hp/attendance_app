import 'package:http/http.dart' as http;

class ApiServices {
  final String apiUrl = 'https://api.escuelajs.co/api/v1';

  Future<http.Response> fetchUsers() async {
    return await http.get(Uri.parse('$apiUrl/users'));
  }
}
