

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/models/order-model.dart';
import 'package:tqabayaapplication/screens/user_pannel/main_screen.dart';

import '../models/cartModels.dart';
import '../utils/app_constant.dart';
import 'generate-order-id-service.dart';

void placeOrder(
    {required BuildContext context,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String customerAddress,
    required String customerDeviceToken}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please wait..');
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
            productId: data['productId'],
            categoryId: data['categoryId'],
            productName: data['categoryId'],
            categoryName: data['categoryName'],
            salePrice: data['salePrice'],
            fullPrice: data['fullPrice'],
            productImages: data['productImages'],
            deliveryTime: data['deliveryTime'],
            isSale: data['isSale'],
            productDescription: data['productDescription'],
            createdAt: DateTime.now(),
            updatedAt: data['updatedAt'],
            productQuantity: data['productQuantity'],
            productTotalPrice: data['productTotalPrice'],
            customerId: user.uid,
            status: false,
            customerName: customerName,
            customerPhone: customerPhone,
            customerAddress: customerAddress,
            customerDeviceToken: customerDeviceToken);

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            'uId': user.uid,
            'customerName': customerName,
            'customerEmail': customerEmail,
            'customerPhone': customerPhone,
            'customerAddress': customerAddress,
            'customereviceToken': customerDeviceToken,
            'orderStatus': false,
            'createdOn': DateTime.now()
          });

          //upload orders

          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          //delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart products $orderModel.productId.tostring()');
          });
        }
      }

      print('Order Confirmed');
      Get.snackbar('Order Confirmed', 'Thankyou for your shopping',
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstant.apptextColor,
          backgroundColor: AppConstant.appSeconderyColor,
          duration: Duration(seconds: 5));

      EasyLoading.dismiss();
      Get.offAll(() => Main_screen());
    } catch (e) {
      print('Error $e');
    }
  }
}
