// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/forget-password-controller.dart';
import '../../utils/app_constant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appSeconderyColor,
          title: const Text(
            "Forget Password",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppConstant.apptextColor),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              isKeyboardVisible
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          height: 220,
                          child: Image.asset(
                            "assets/images/spalsh.png",
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: Get.height / 90,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: AppConstant.appSeconderyColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
              //      SizedBox(
              //   height: Get.height / 75,
              // ),

              SizedBox(
                height: Get.height / 50,
              ),

              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSeconderyColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "Forget",
                      style: TextStyle(color: AppConstant.apptextColor),
                    ),
                    onPressed: () async {
                      String email = emailController.text.trim();

                      if (email.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSeconderyColor,
                          colorText: AppConstant.apptextColor,
                        );
                      } else {
                        String email = emailController.text.trim();
                        forgetPasswordController.forgetPasswordMethood(email);
                      }
                    },
                  ),
                ),)

            ],
          ),
        ),
      );
    });
  }
}
