import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features_fake_apis/repositories/create_user.dart';
import 'package:todo_app/features_fake_apis/view/all_users_page.dart';
import 'package:todo_app/features_fake_apis/view_modal/users_view_model.dart';

class CreateUserViewModel extends GetxController {
  final CreateUser createNewUser = CreateUser();
  final picker = ImagePicker();
  String image = 'https://picsum.photos/id/237/200/300';
  final RxBool isSaving = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UsersViewModel controller = Get.put(UsersViewModel());

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.15,
          child: Column(
            children: <Widget>[
              _buildListTile(context, Icons.photo_camera, 'Take a picture',
                  pickImageFromCamera),
              _buildListTile(context, Icons.photo_album, 'Upload from gallery',
                  pickImageFromGallery),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile(
      BuildContext context, IconData icon, String text, Function() onTap) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Future pickImageFromCamera() async => _pickImage(ImageSource.camera);
  Future pickImageFromGallery() async => _pickImage(ImageSource.gallery);

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = pickedFile.path;
        print(image);
      }
    } on PlatformException catch (e) {
      print('Failed to load image: $e');
    }
  }

  Future<void> createUser() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    isSaving.value = true;

    final newUser =
        await createNewUser.createNewUser(name, email, password, image);

    if (newUser != null) {
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      Get.off(AllUsersPage());
      controller.fetchAllUsers();
      isSaving.value = false;
      Fluttertoast.showToast(
        msg: 'User Created Successfully',
        backgroundColor: Colors.lightGreen,
        fontSize: 16,
      );
    } else {
      isSaving.value = false;
      Fluttertoast.showToast(
        msg: 'Error creating User',
        backgroundColor: Colors.redAccent,
        fontSize: 16,
      );
    }
  }
}
