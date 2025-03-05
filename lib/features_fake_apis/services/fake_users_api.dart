import 'package:http/http.dart' as http;

class ApiServices {
 // final String apiUrl = 'https://api.escuelajs.co/api/v1';

  Future<http.Response> fetchUsers(url) async {
    return await http.get(Uri.parse(url));
  }
}
