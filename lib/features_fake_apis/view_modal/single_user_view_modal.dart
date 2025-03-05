import 'package:get/get.dart';
import 'package:todo_app/features_fake_apis/models/single_user_model.dart';
import 'package:todo_app/features_fake_apis/repositories/get_single_user.dart';

class SingleUserViewModal extends GetxController {
  final GetSingleUser getUser = GetSingleUser();
  final Rx<SingleUserModel?> _user = Rx<SingleUserModel?>(null);
  SingleUserModel? get user => _user.value;
  final RxBool isLoading = false.obs;

  Future<void> fetchSingleUser(int? userId) async {
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    isLoading.value = true;
    try {
      final fetchedUser = await getUser.getSingleUser(userId);
      _user.value = fetchedUser;
      print(user!.name);
      print('@@@@@@@@@@@@@@@@@@@@@@@@@');
    } catch (e) {
      throw Exception('Failed to load Users: $e');
    }
    isLoading.value = false;
  }
}
