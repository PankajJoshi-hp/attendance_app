import 'package:todo_app/features_fake_apis/services/create_user_api.dart';

class CreateUser {
  final CreateUserApi _userService = CreateUserApi();

  Future<Map<String, dynamic>?> createNewUser(
      String name, String email, String password, String avatar) async {
    final userData = {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
    return await _userService.createUser(userData);
  }
}
