import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/signup_controller.dart';
import 'package:todo_app/main.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // const SignUpPage({super.key});
  final SignupController signupControl = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          width: double.infinity,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 30,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Create an account',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Start writing your todos today!',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: signupControl.usernameController,
                    decoration: InputDecoration(
                        label: Text(
                          'Enter your username',
                          style: TextStyle(fontSize: 18),
                        ),
                        contentPadding: EdgeInsets.all(24),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                TextFormField(
                  controller: signupControl.emailController,
                  decoration: InputDecoration(
                      label: Text(
                        'Enter Your Email',
                        style: TextStyle(fontSize: 18),
                      ),
                      contentPadding: EdgeInsets.all(24),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                TextFormField(
                  controller: signupControl.numberController,
                  decoration: InputDecoration(
                      label: Text(
                        'Enter Your Phone Number',
                        style: TextStyle(fontSize: 18),
                      ),
                      contentPadding: EdgeInsets.all(24),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                TextFormField(
                  controller: signupControl.passwordController,
                  decoration: InputDecoration(
                      label: ListTile(
                        title: Text(
                          'Enter Your Password',
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Icon(
                          Icons.password,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 24, bottom: 24, left: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0XFF0E64D2)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                      ),
                      onPressed: () {
                        signupControl.postData(context);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      height: 1,
                    ),
                    Text(
                      'Or With',
                      style: TextStyle(fontSize: 24),
                    ),
                    Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      height: 1,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0XFF0E64D2)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 30,
                      children: <Widget>[
                        Icon(
                          Icons.facebook,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          'Signup with facebook',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 30,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          'Signup with Google',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
