import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:test_cli/app/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  //const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.7,
                height: Get.width * 0.7,
                child: Lottie.asset("assets/lottie/login.json"),
              ),
              SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: ElevatedButton(
                  onPressed: () => authC.login(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/logo/google.png"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Sign In with Google",
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text("V23.01")
            ],
          ),
        ),
      )),
    );
  }
}
