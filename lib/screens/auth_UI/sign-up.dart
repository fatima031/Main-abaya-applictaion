import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/sign-up-controller.dart';
import '../../utils/app_constant.dart';
import 'sign-in-screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appSeconderyColor,
          title: const Text(
            "Sign up",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppConstant.apptextColor),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Wellcome To My App',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppConstant.appSeconderyColor),
                  ),
                ),
                SizedBox(
                  height: Get.height / 90,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: nameController,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'User Name',
                            prefixIcon: const Icon(Icons.person),
                            contentPadding:
                                const EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            contentPadding:
                                const EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                //      SizedBox(
                //   height: Get.height / 75,
                // ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Obx(
                          () => TextFormField(
                            obscureText:
                                signUpController.isPasswordVisible.value,
                            controller: passwordController,
                            cursorColor: AppConstant.appSeconderyColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      signUpController.isPasswordVisible
                                          .toggle();
                                    },
                                    child:
                                        signUpController.isPasswordVisible.value
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility)),
                                contentPadding:
                                    const EdgeInsets.only(top: 2, left: 8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ))),

                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phoneController,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            prefixIcon: const Icon(Icons.phone),
                            contentPadding:
                                const EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: cityController,
                        cursorColor: AppConstant.appSeconderyColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'City',
                            prefixIcon: const Icon(Icons.location_history),
                            contentPadding:
                                const EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
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
                          String name = nameController.text.trim();
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          String phone = phoneController.text.trim();
                          String city = cityController.text.trim();
                          String userDeviceToken = "";
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          phoneController.clear();
                          cityController.clear();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phone.isEmpty ||
                              city.isEmpty) {
                            Get.snackbar("Error", "Please enter all details!",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: AppConstant.apptextColor,
                                backgroundColor: AppConstant.appSeconderyColor);
                          } else {
                            UserCredential? userCredential =
                                await signUpController.signUpMethood(
                                    name,
                                    email,
                                    password,
                                    phone,
                                    city,
                                    userDeviceToken);

                            if (userCredential != null) {
                              Get.snackbar("Verification email sent!",
                                  "Please check your email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: AppConstant.apptextColor,
                                  backgroundColor:
                                      AppConstant.appSeconderyColor);
                              FirebaseAuth.instance.signOut();
                              Get.offAll(() => SignIn());
                            }
                          }
                        },
                        child: const Text(
                          "SIGN UP",
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
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: AppConstant.appSeconderyColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const SignIn());
                      },
                      child: const Text(
                        "SIGN IN",
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
        ),
      );
    });
  }
}
