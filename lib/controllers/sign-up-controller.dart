// ignore_for_file: body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/controllers/get-device-token-controller.dart';
import 'package:tqabayaapplication/models/userModels.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethood(
    String userName,
    String userEmail,
    String userPassword,
    String userPhone,
    String userCity,
    String userDeviceToken,
  ) async {
    //get device token use login via email
    GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());
    try {
      EasyLoading.show(status: "please Wait..");
      //for creat user in firebasei mean signup
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

//send email verification
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: userEmail,
          phone: userPhone,
          userImg: "",
          userDeviceToken: getDeviceTokenController.deviceToken.toString(),
          country: "",
          userAddress: "",
          street: "",
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: userCity);

      //add data into database
      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
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
