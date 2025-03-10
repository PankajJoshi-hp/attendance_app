import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/features_fake_apis/services/fake_users_api.dart';

class UpdateUser {
  final ApiServices apiService = ApiServices();

  Future<http.Response> updateUser(
      int userId, Map<String, dynamic> body) async {
    final String? baseUrl = dotenv.env['API_KEY_USERS'];
    String url = '$baseUrl/$userId';

    return await apiService.fetchUsers(
      url,
      method: 'PUT',
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
