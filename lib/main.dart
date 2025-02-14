import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/components/break_page.dart';
import 'package:todo_app/components/login_page.dart';
import 'package:todo_app/controllers/controller.dart';
import 'package:todo_app/controllers/deviceStatusController.dart';
import 'package:todo_app/controllers/logout_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var get_Token = await prefs.getString('token');
  print(get_Token);
  runApp(MyApp(getToken: get_Token));
}

class MyApp extends StatelessWidget {
  final getToken;
  MyApp({required this.getToken});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: getToken == null ? LogInPage() : HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogoutController logoutControl = Get.put(LogoutController());
  Controller reportControl = Get.put(Controller());
  DeviceStatusController deviceInfoControl = Get.put(DeviceStatusController());
  String? selectedButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Image.asset('assets/images/human.png'),
                  ),
                  SizedBox(width: 12),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hello,',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Test User...',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ],
              ),
              Obx(() => logoutControl.isLogoutLoading.value == false
                  ? RichText(
                      text: TextSpan(
                          text: 'Logout',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              logoutControl.logout();
                            }))
                  : CircularProgressIndicator())
            ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: reportControl.reportButtons
                  .map((button) => GestureDetector(
                        onTap: () {
                          if (button['id'] != 2) {
                            reportControl.focusTextField(context);
                            selectedButton = button['type'];
                          } else {
                            selectedButton = null;
                            Get.to(BreakPage());
                          }
                          // controller
                          //     .updateReport(controller.reportController.text);
                          print("${button['type']} Clicked");
                          // controller.selectedId = button['id'];

                          setState(() {});
                        },
                        child: Container(
                          width: 160,
                          height: 100,
                          decoration: BoxDecoration(
                            color: button['background_color'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(button['icon'],
                                  size: 40, color: Colors.white),
                              SizedBox(height: 8),
                              Text(button['type'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
            TextButton(
              onPressed: () async {
                print('###########################');
                deviceInfoControl.getDeviceInfo();
                await deviceInfoControl.getCurrentLocation();
                deviceInfoControl.getNetworkInfo();
              },
              child: Text(
                  "Latitude = ${deviceInfoControl.currentLocation?.latitude} ; Longitude = ${deviceInfoControl.currentLocation?.longitude}; ${deviceInfoControl.infoObject['wifi_name']}"),
            )
          ],
        ),
      ),
      bottomNavigationBar: selectedButton == null
          ? SizedBox.shrink()
          : Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          // maxLines: 2,
                          focusNode: reportControl.focusNode,
                          controller: reportControl.reportController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Your Text Here..',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            contentPadding: EdgeInsets.all(20),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0XFF8B0000), width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0XFF8B0000), width: 2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            // print(jsonEncode(deviceInfoControl.infoObject));
                            // print('------------------------------');
                            reportControl.sendReport(selectedButton);
                          },
                          icon: Icon(Icons.send_rounded,
                              size: 32, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
