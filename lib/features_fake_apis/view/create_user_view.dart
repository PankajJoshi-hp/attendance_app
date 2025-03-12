import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features_fake_apis/view/all_users_page.dart';
import 'package:todo_app/features_fake_apis/view_modal/create_user_view_model.dart';

class CreateUserView extends StatelessWidget {
  CreateUserView({super.key});
  final CreateUserViewModel createUserModel = Get.put(CreateUserViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New User'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 30,
              children: <Widget>[
                buildTextFormField(
                    createUserModel.nameController, 'Entername here..', context),
                buildTextFormField(
                    createUserModel.emailController, 'Enter email here..', context),
                buildTextFormField(createUserModel.passwordController,
                    'Enter password here..', context),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height*0.04,
                  child: ElevatedButton(
                      onPressed: () {
                        createUserModel.showBottomSheet(context);
                      },
                      child: Text('Choose Your Avatar')),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width*0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.off(AllUsersPage());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.redAccent)),
                          child: Text(
                            'Cancel', style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Obx(
                      () => createUserModel.isSaving.value == false
                          ? SizedBox(
                            width: MediaQuery.sizeOf(context).width*0.3,
                            child: ElevatedButton(
                                onPressed: () {
                                  createUserModel.createUser();
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.lightBlue)),
                                child: Text(
                                  'Save', style: TextStyle(fontSize: 16),
                                )),
                          )
                          : CircularProgressIndicator(),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

Widget buildTextFormField(controller, hintText, context) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12)),
    ),
  );
}
