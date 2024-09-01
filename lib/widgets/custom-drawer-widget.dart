// ignore_for_file: sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

import '../screens/auth_UI/welcomeScreen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  AppConstant.appMainName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppConstant.appMainColor,
                  child: Image(image: AssetImage("assets/images/spalsh.png")),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
              thickness: 1.5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.apptextColor,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstant.apptextColor,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstant.apptextColor,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contact",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: Icon(
                  Icons.help,
                  color: AppConstant.apptextColor,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => Welcome_screen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppConstant.apptextColor),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: AppConstant.apptextColor,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appSeconderyColor,
      ),
    );
  }
}
