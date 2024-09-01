import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tqabayaapplication/controllers/google-signin-controller.dart';
import 'package:tqabayaapplication/screens/auth_UI/sign-in-screen.dart';

import '../../utils/app_constant.dart';

class Welcome_screen extends StatelessWidget {
  Welcome_screen({super.key});

  final GoogleSigninController _googleSigninController =
      Get.put(GoogleSigninController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Welcome To My App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppConstant.apptextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                height: 220,
                child: Image.asset(
                  "assets/images/spalsh.png",
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Happy Shopping",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppConstant.apptextColor2),
                ),
              ),
              SizedBox(
                height: Get.height / 12,
              ),
              Material(
                child: Container(
                  width: Get.width / 1.2,
                  height: Get.height / 12,
                  decoration: BoxDecoration(
                      color: AppConstant.appMainColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextButton.icon(
                      onPressed: () {
                        _googleSigninController.signInWithGoogle();
                      },
                      icon: Image.asset(
                        "assets/images/final-google-logo.png",
                        width: Get.width / 12,
                        height: Get.height / 12,
                      ),
                      label: const Text(
                        "Sign in with Google",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppConstant.apptextColor),
                      )),
                ),
              ),
              SizedBox(
                height: Get.height / 50,
              ),
              Material(
                child: Container(
                  width: Get.width / 1.2,
                  height: Get.height / 12,
                  decoration: BoxDecoration(
                      color: AppConstant.appMainColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextButton.icon(
                      onPressed: () {
                        Get.to(() => SignIn());
                      },
                      icon: const Icon(
                        Icons.email,
                        color: AppConstant.apptextColor,
                      ),
                      label: const Text(
                        "Sign in with Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppConstant.apptextColor),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
