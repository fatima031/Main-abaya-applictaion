import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';


import '../../controllers/cart-price-controller.dart';
import '../../controllers/get-customer-device-token-controller.dart';
import '../../models/cartModels.dart';
import '../../services/place-order-service.dart';
import '../../utils/app_constant.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
          'Checkout Screen',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppConstant.apptextColor,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
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
                        CartModel cartModel = CartModel(
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
                            productTotalPrice:
                                productData['productTotalPrice']);

                        //calculate price
                        productPriceController.fatchProductPrice();

                        return SwipeActionCell(
                            trailingActions: [
                              SwipeAction(
                                  title: 'Delete',
                                  forceAlignmentToBoundary: true,
                                  performsFirstActionWithFullSwipe: true,
                                  onTap: (CompletionHandler handler) async {
                                    print('Deleted');
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .delete();
                                  })
                            ],
                            key: ObjectKey(cartModel.productId),
                            child: Card(
                              elevation: 5,
                              color: AppConstant.apptextColor,
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: AppConstant.appMainColor,
                                    backgroundImage: NetworkImage(
                                        cartModel.productImages[0])),
                                title: Text(
                                  cartModel.productName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppConstant.appMainColor,
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cartModel.productTotalPrice.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: AppConstant.appMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }));
            }

            return Container();
          }),
      bottomNavigationBar: Container(
        color: AppConstant.appMainColor,
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Obx(
              () => Text(
                "Total : ${productPriceController.totalPrice.value.toStringAsFixed(1)} : PKR",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppConstant.apptextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: const BoxDecoration(
                    color: AppConstant.apptextColor,
                    // borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: TextButton(
                      onPressed: () {
                        showCustomBottomSheet();
                      },
                      child: const Text(
                        "Confirm Order",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppConstant.appMainColor),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheet() {
    Get.bottomSheet(
        Container(
          height: Get.height * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'Phone',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: addressController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.appMainColor,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                    onPressed: () async {
                      if (nameController.text != '' &&
                          phoneController.text != '' &&
                          emailController.text != ' ' &&
                          addressController.text != '')
                      {
                        String name = nameController.text.trim();
                        String phone = phoneController.text.trim();
                        String email = emailController.text.trim();
                        String address = addressController.text.trim();

                        String customerToken = await getCustomerDeviceToken();

                        placeOrder(
                          context: context,
                          customerName: name,
                          customerEmail: email,
                          customerPhone: phone,
                          customerAddress: address,
                          customerDeviceToken: customerToken,
                        );
                      }
                      else {
                        Get.snackbar('Error', 'Please fill all details',
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: AppConstant.apptextColor,
                            backgroundColor: AppConstant.appSeconderyColor);
                      }
                    },
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        color: AppConstant.apptextColor,
                      ),
                    ))
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        elevation: 6);
  }
}
