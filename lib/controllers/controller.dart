import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/components/login_page.dart';
import 'package:todo_app/controllers/deviceStatusController.dart';
import 'package:todo_app/reusable_widgets/app_colors.dart';
import 'package:todo_app/reusable_widgets/todo_modal.dart';

class Controller extends GetxController {
  final String apiUrl = 'https://hpcrm.apinext.in/api/v1/users/report';
  final String secondUrl =
      'https://hpcrm.apinext.in/api/v1/users/report/67a1c9446e2131c6dea76511';
  final formKey = GlobalKey<FormState>();
  // String text = 'No todos added';
  final TextEditingController textController = TextEditingController();
  final TextEditingController reportController = TextEditingController();
  // final TextEditingController standupController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  DeviceStatusController deviceInfoControl = Get.put(DeviceStatusController());

  List<Map<String, dynamic>> reportButtons = [
    {
      'id': 1,
      'type': 'STANDUP',
      'icon': Icons.timer_outlined,
      'background_color': AppColors.lightBlue
    },
    {
      'id': 2,
      'type': 'BREAK',
      'icon': Icons.lunch_dining,
      'background_color': AppColors.lightGreen
    },
    {
      'id': 3,
      'type': 'REPORT',
      'icon': Icons.description,
      'background_color': AppColors.redAccent
    }
  ];

  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }

  void focusTextField(context) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> sendReport(selectedButtonType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var get_Token = await prefs.getString('token');
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode({
            'report_type': selectedButtonType,
            'report_description': reportController.text,
            'device_info': deviceInfoControl.infoObject,
          }),
          headers: {
            "Content-Type": "application/json",
            "Cookie": 'token=$get_Token'
          });
      print('------------------------------');
      print(response.body);
      print('------------------------------');

      print(response.statusCode);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        reportController.clear();
        print(data);
        Fluttertoast.showToast(
            msg: 'Report sent Successfully',
            backgroundColor: Colors.lightGreen,
            fontSize: 16);
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
          msg: 'Authorization failed',
          backgroundColor: Colors.redAccent,
          fontSize: 16,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.to(LogInPage());
      } else {
        Fluttertoast.showToast(
          msg: 'Please contact HR to complete your profile.',
          backgroundColor: Colors.redAccent,
          fontSize: 16,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

//   Future<void> updateReport(String reportId, String updatedText) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var get_Token = await prefs.getString('token');

//   try {
//     final response = await http.put(
//       Uri.parse(secondUrl),
//       body: jsonEncode({
//         "report_type": "STANDUP",
//         "report_description": updatedText,
//         "user_id": "U069HJB3HEW",
//         "time": DateTime.now().toIso8601String(),
//       }),
//       headers: {
//         "Content-Type": "application/json",
//         "Cookie": 'token=$get_Token'
//       },
//     );

//     print('------------------------------');
//     print(response.body);
//     print('------------------------------');

//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(
//         msg: 'Report updated successfully',
//         backgroundColor: Colors.lightGreen,
//         fontSize: 16,
//       );
//     } else if (response.statusCode == 401) {
//       Fluttertoast.showToast(
//         msg: 'Authorization failed',
//         backgroundColor: Colors.redAccent,
//         fontSize: 16,
//       );
//       await prefs.remove('token');
//       Get.to(LogInPage());
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Failed to update report. Please try again.',
//         backgroundColor: Colors.redAccent,
//         fontSize: 16,
//       );
//     }
//   } catch (e) {
//     print('Error updating report: $e');
//   }
// }
}
