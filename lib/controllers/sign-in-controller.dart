import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/userModels.dart';
import '../utils/app_constant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethood(
    String userEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: "please Wait..");
      //for creat user in firebasei mean signup
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstant.apptextColor,
          backgroundColor: AppConstant.appSeconderyColor);
    }
  }
}
