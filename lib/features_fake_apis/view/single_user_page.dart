import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features_fake_apis/view_modal/single_user_view_modal.dart';

class SingleUserPage extends StatefulWidget {
  final int? userId;
  const SingleUserPage({super.key, required this.userId});

  @override
  State<SingleUserPage> createState() => _SingleUserPageState();
}

class _SingleUserPageState extends State<SingleUserPage> {
  final SingleUserViewModal singleUser = Get.put(SingleUserViewModal());

  @override
  void initState() {
    super.initState();
    singleUser.fetchSingleUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          Obx(() => IconButton(
                icon: singleUser.isEditing.value
                    ? (singleUser.isSaving.value
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(Icons.check))
                    : Icon(Icons.edit),
                onPressed: () {
                  if (singleUser.isEditing.value) {
                    singleUser.updateUser(widget.userId);
                  } else {
                    singleUser.isEditing.value = true;
                  }
                },
              ))
        ],
      ),
      body: Obx(() {
        if (singleUser.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (singleUser.user == null) {
          return const Center(
            child: Text(
              'Failed to load user data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        final user = singleUser.user!;
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user.avatar != null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            user.avatar!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Obx(() => singleUser.isEditing.value
                                ? TextField(
                                    controller: singleUser.nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Name',
                                    ),
                                  )
                                : Text(
                                    user.name ?? "No Name",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  )),
                            const SizedBox(height: 8),
                            Text(
                              user.email ?? "No Email",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              user.role ?? "No Role",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     singleUser.fetchSingleUser(widget.userId);
                  //   },
                  //   icon: const Icon(Icons.refresh),
                  //   label: const Text('Refresh Data'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blueAccent,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 12),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     textStyle: const TextStyle(
                  //         fontSize: 16, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
