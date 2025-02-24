import 'dart:ui';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.9)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: Image(
                image: AssetImage('assets/images/Ellips.png'),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Attendance',
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: Image(
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
