import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/components/login_page.dart';
import 'package:todo_app/components/onboarding_one.dart';
import 'package:todo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync:
          this, // this prevents unnecessary resource usage when the animation is off-screen.
      duration: const Duration(seconds: 2),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    Timer(const Duration(seconds: 2), navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var get_Token = prefs.getString('token');
    SharedPreferences prefsBool = await SharedPreferences.getInstance();
    var get_bool = prefsBool.getBool('isLoggedOut');
    if (get_Token != null) {
      Get.offAll(() => HomePage());
    } else if (get_bool == true) {
      Get.off(LogInPage());
    } else {
      Get.off(() => Onboarding());
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: const Image(
                image: AssetImage('assets/images/Ellips.png'),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Attendance App',
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).height * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: const Image(
                image: AssetImage('assets/images/Ellipse.png'),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
