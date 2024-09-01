import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/screens/auth_UI/sign-in-screen.dart';

import '../utils/app_constant.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> forgetPasswordMethood(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "please Wait..");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
          "Request sent successfully", "Password resend link to $userEmail",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstant.apptextColor,
          backgroundColor: AppConstant.appSeconderyColor);
      Get.offAll(() => SignIn());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstant.apptextColor,
          backgroundColor: AppConstant.appSeconderyColor);
    }
  }
}
