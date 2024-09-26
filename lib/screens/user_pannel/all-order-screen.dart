import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart-price-controller.dart';

import '../../models/order-model.dart';
import '../../utils/app_constant.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    // double _height = 0;
    // _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.apptextColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: AppConstant.apptextColor),
        title: const Text(
          'All Orders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppConstant.apptextColor,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(user!.uid)
              .collection('confirmOrders')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: Get.height / 5,
                child: const Center(child: CupertinoActivityIndicator()),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No products found!"),
              );
            }
            if (snapshot.data != null) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final productData = snapshot.data!.docs[index];
                        OrderModel orderModel = OrderModel(
                            productId: productData['productId'],
                            categoryId: productData['categoryId'],
                            productName: productData['categoryId'],
                            categoryName: productData['categoryName'],
                            salePrice: productData['salePrice'],
                            fullPrice: productData['fullPrice'],
                            productImages: productData['productImages'],
                            deliveryTime: productData['deliveryTime'],
                            isSale: productData['isSale'],
                            productDescription:
                                productData['productDescription'],
                            createdAt: productData['createdAt'],
                            updatedAt: productData['updatedAt'],
                            productQuantity: productData['productQuantity'],
                            productTotalPrice: productData['productTotalPrice'],
                            customerId: productData['customerId'],
                            status: productData['status'],
                            customerName: productData['customerName'],
                            customerPhone: productData['customerPhone'],
                            customerAddress: productData['customerAddress'],
                            customerDeviceToken:
                                productData['customerDeviceToken']);

                        //calculate price
                        productPriceController.fatchProductPrice();

                        return Card(
                          elevation: 5,
                          color: AppConstant.apptextColor,
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppConstant.appMainColor,
                                backgroundImage:
                                    NetworkImage(orderModel.productImages[0])),
                            title: Text(
                              orderModel.productName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appMainColor,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  orderModel.productTotalPrice.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppConstant.appMainColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                orderModel.status != true
                                    ? const Text(
                                        'Pending',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green
                                          ,
                                        ),
                                      )
                                    : const Text(
                                        'Delivered',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        );
                      }));
            }

            return Container();
          }),
    );
  }
}
