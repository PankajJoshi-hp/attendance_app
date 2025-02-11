import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:todo_app/components/sign_up_page.dart';
import 'package:todo_app/controllers/controller.dart';
import 'package:todo_app/controllers/login_controller.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPasswordVisible = false;
  final LoginController loginControl = Get.put(LoginController());
  final Controller textController = Get.put(Controller());

  void handleVisiblity() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        child: Form(
            key: textController.formKey,
            child: Column(
              spacing: 30,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
                Text(
                  'Hi, Welcome Back! 👋',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 8),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                        TextFormField(
                          controller: loginControl.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text(
                                'example@gmail.com',
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
                      ],
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                    TextFormField(
                      controller: loginControl.passwordController,
                      obscureText: isPasswordVisible ? false : true,
                      decoration: InputDecoration(
                          label: Text(
                            'Enter Your Password',
                            style: TextStyle(fontSize: 18),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility_off,
                              size: 20,
                            ),
                            onPressed: handleVisiblity,
                            color: Colors.black54,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      leading: Checkbox(
                        value: true,
                        onChanged: (value) => value,
                      ),
                      title: Text(
                        'Remember Me',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    )),
                    Text(
                      'Forgot PassWord?',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFE86969)),
                    )
                  ],
                ),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0XFF0E64D2)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          onPressed: () {
                            if (textController.formKey.currentState!
                                .validate()) {
                              print('Logged in successfully');
                            } else {
                              print('Please fill email field');
                            }
                            loginControl.login(context);
                          },
                          child: loginControl.isLoginLoading.value == false
                              ? Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator()),
                    )),
                Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width * 0.34,
                      height: 1,
                    ),
                    Text(
                      'Or With',
                      style: TextStyle(fontSize: 24),
                    ),
                    Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width * 0.34,
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
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'Todo added successfully',
                          backgroundColor: Colors.lightGreen);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 50,
                      children: <Widget>[
                        Icon(
                          Icons.facebook,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          'Login with facebook',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
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
                      spacing: 50,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          'Login with Google',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Signup',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(SignUpPage());
                          },
                      ),
                    )
                  ],
                )
              ],
            )),
      ))),
    );
  }
}
