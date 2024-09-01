// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/get-user-data-controller.dart';
import '../../controllers/sign-in-controller.dart';
import '../../utils/app_constant.dart';
import '../user_pannel/main_screen.dart';
import '../admin_pannel/admin_main_screen.dart';
import 'forget-password-screen.dart';
import 'sign-up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appSeconderyColor,
          title: const Text(
            "SignIn",
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: Get.width,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      () => TextFormField(
                        obscureText: signInController.isPasswordVisible.value,
                        controller: passwordController,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  signInController.isPasswordVisible.toggle();
                                },
                                child: signInController.isPasswordVisible.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            contentPadding: EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forget Paasword?",
                    style: TextStyle(
                        color: AppConstant.appSeconderyColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 50,
              ),

              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                      color: AppConstant.appMainColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextButton(
                      onPressed: () async {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        emailController.clear();
                        passwordController.clear();

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar("Error", "Please enter all details!",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: AppConstant.apptextColor,
                              backgroundColor: AppConstant.appSeconderyColor);
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethood(
                                  email, password);

                          var userData = await getUserDataController
                              .getUserdata(userCredential!.user!.uid);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              if (userData[0]['isAdmin' ] == true) {
                                Get.offAll(() => Admin_Main_Screen());
                                Get.snackbar("Success Admin Login",
                                    "Login successfully !",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: AppConstant.apptextColor,
                                    backgroundColor:
                                        AppConstant.appSeconderyColor);
                              } else {
                                Get.offAll(() => Main_screen());
                                Get.snackbar("Success User Login",
                                    "Login successfully !",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: AppConstant.apptextColor,
                                    backgroundColor:
                                        AppConstant.appSeconderyColor);
                              }
                            } else {
                              Get.snackbar("Error",
                                  "Please verify your email before login",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: AppConstant.apptextColor,
                                  backgroundColor:
                                      AppConstant.appSeconderyColor);
                            }
                          } else {
                            Get.snackbar("Error", "Please try again!",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: AppConstant.apptextColor,
                                backgroundColor: AppConstant.appSeconderyColor);
                          }
                        }
                      },
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppConstant.apptextColor),
                      )),
                ),
              ),
              SizedBox(
                height: Get.height / 70,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppConstant.appSeconderyColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => Signup());
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppConstant.appSeconderyColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
