import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/app.dart';
import 'package:hello_flutter/login_signup/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _homeNavigation();
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/INT_transparent.png",
          height: 200,
        ),
      ),
    );
  }

  void _homeNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("islog") == null || prefs.get("islog") == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => MyApp());
    }
  }
}
