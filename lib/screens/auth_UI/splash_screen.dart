// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/controllers/get-user-data-controller.dart';
import 'package:tqabayaapplication/screens/admin_pannel/admin_main_screen.dart';
import 'package:tqabayaapplication/screens/auth_UI/welcomeScreen.dart';
import 'package:tqabayaapplication/screens/user_pannel/main_screen.dart';

import 'package:tqabayaapplication/utils/app_constant.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggedin(context);
    });
  }

  Future<void> loggedin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getuserDataController =
          Get.put(GetUserDataController());
      var userData = await getuserDataController.getUserdata(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => Admin_Main_Screen());
      } else {
        Get.offAll(() => Main_screen());
      }
    } else {
      Get.to(() => Welcome_screen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size= MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppConstant.appMainColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/main Image.jpg",
                    ),
                    height: 40,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                // width: size.width,
                width: Get.width,
                child: Text(
                  AppConstant.appCreatedBy,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: AppConstant.apptextColor),
                ),
              )
            ],
          ),
        ));
  }
}
