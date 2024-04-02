import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/app.dart';
import 'package:hello_flutter/login_signup/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool showUsernameError = false.obs;
  final RxBool showPasswordError = false.obs;

  String? usernameValue;
  String? passwordValue;

  String usernameH = "ac.abishek@gmail.com";
  String passH = "12345678";

  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  LoginPage({super.key});

  bool isEmailValid(String input) {
    return emailRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: showUsernameError.value
                        ? Colors.red
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
                fillColor: showUsernameError.value
                    ? Colors.red.withOpacity(0.1)
                    : Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (value) {
                showUsernameError.value = !isEmailValid(value);
              },
            )),
        Obx(() {
          if (showUsernameError.value) {
            return const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Invalid email format",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox(height: 10);
          }
        }),
        Obx(() => TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: showPasswordError.value
                        ? Colors.red
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
                fillColor: showPasswordError.value
                    ? Colors.red.withOpacity(0.1)
                    : Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              obscureText: true,
              onChanged: (value) {
                showPasswordError.value = value.length < 8;
              },
            )),
        Obx(() {
          if (showPasswordError.value) {
            return const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Password must be at least 8 characters long",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox(height: 10);
          }
        }),
        ElevatedButton(
          onPressed: () async {
            // Reset error messages when login button is pressed
            showUsernameError.value = !isEmailValid(usernameController.text);
            showPasswordError.value = passwordController.text.length < 8;

            if (!showUsernameError.value && !showPasswordError.value) {
              dynamic res = await getBollRes(
                usernameController.text,
                passwordController.text,
              );

              if (res == true) {
                Get.offAll(MyApp());
              } else {
                _showErrorDialog(context);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text("Forgot password?"),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: const Text("Sign Up"),
        )
      ],
    );
  }

  Future<bool> getBollRes(a, b) async {
    SharedPreferences prep = await SharedPreferences.getInstance();
    usernameValue = prep.getString("username");
    passwordValue = prep.getString("password");
    prep.setString("islog", "true");

    if (a == usernameValue && b == passwordValue) {
      return true;
    } else {
      return false;
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Incorrect username or password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
