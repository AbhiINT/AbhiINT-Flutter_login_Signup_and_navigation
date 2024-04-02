import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_flutter/login_signup/login_page.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final showUsernameError = false.obs;
  final showPasswordError = false.obs;
  final showPhoneNumberError = false.obs;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneNumberRegex = RegExp(r'^[0-9]{10}$');

  bool isEmailValid(String input) {
    return emailRegex.hasMatch(input);
  }

  bool isPhoneNumberValid(String input) {
    return phoneNumberRegex.hasMatch(input);
  }

  Future<void> signUp() async {
    showUsernameError(!isEmailValid(usernameController.text));
    showPhoneNumberError(!isPhoneNumberValid(phoneNumberController.text));
    showPasswordError(passwordController.text.length < 8);

    if (!showUsernameError.value &&
        !showPhoneNumberError.value &&
        !showPasswordError.value &&
        passwordController.text == confirmPasswordController.text) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("username", usernameController.text);
      await pref.setString("password", passwordController.text);
      await pref.setString("fname", firstNameController.text);
      await pref.setString("lname", lastNameController.text);
      await pref.setString("phoneNumber", phoneNumberController.text);

      if (pref.getString("username") != null) {
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Success'),
        content: const Text('Signup Success'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAll(() => LoginPage());
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: const Text('Signup Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: controller.firstNameController,
              decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: controller.lastNameController,
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => TextFormField(
                controller: controller.usernameController,
                onChanged: (value) {
                  controller.showUsernameError(!controller.isEmailValid(value));
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  errorText: controller.showUsernameError.value
                      ? 'Invalid email format'
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => TextFormField(
                controller: controller.phoneNumberController,
                onChanged: (value) {
                  controller.showPhoneNumberError(
                      !controller.isPhoneNumberValid(value));
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  errorText: controller.showPhoneNumberError.value
                      ? 'Invalid phone number format'
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                onChanged: (value) {
                  controller.showPasswordError(value.length < 8);
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  errorText: controller.showPasswordError.value
                      ? 'Password must be at least 8 characters'
                      : null,
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: controller.confirmPasswordController,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              autofocus: true,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey)),
              onPressed: () => controller.signUp(),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
