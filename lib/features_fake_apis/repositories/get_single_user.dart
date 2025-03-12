import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/features_fake_apis/models/single_user_model.dart';
import 'package:todo_app/features_fake_apis/services/fake_users_api.dart';

class GetSingleUser {
  final ApiServices apiService = ApiServices();

  Future<SingleUserModel> getSingleUser(int? userId) async {
    String? baseUrl = dotenv.env['API_KEY_USERS'];
    String url = '$baseUrl/$userId';
    final response = await apiService.fetchUsers(url);

    print('##########################');
    print('Response Status Code: ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      return SingleUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
