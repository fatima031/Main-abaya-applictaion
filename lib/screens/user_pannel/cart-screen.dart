import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';


import '../../controllers/cart-price-controller.dart';
import '../../models/cartModels.dart';
import '../../utils/app_constant.dart';
import 'checkout-screen.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({super.key});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
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
          'Cart Screen',
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
                                    SizedBox(
                                      width: Get.width / 20.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (cartModel.productQuantity > 0) {
                                          await FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(user!.uid)
                                              .collection('cartOrders')
                                              .doc(cartModel.productId)
                                              .update({
                                            'productQuantity':
                                                cartModel.productQuantity + 1,
                                            'productTotalPrice': double.parse(
                                                    cartModel.fullPrice) +
                                                double.parse(
                                                        cartModel.fullPrice) *
                                                    (cartModel.productQuantity)
                                          });
                                        }
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor:
                                            AppConstant.appMainColor,
                                        radius: 14.0,
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppConstant.apptextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (cartModel.productQuantity > 1) {
                                          await FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(user!.uid)
                                              .collection('cartOrders')
                                              .doc(cartModel.productId)
                                              .update({
                                            'productQuantity':
                                                cartModel.productQuantity - 1,
                                            'productTotalPrice': (double.parse(
                                                    cartModel.fullPrice) *
                                                (cartModel.productQuantity - 1))
                                          });
                                        }
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor:
                                            AppConstant.appMainColor,
                                        radius: 14.0,
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppConstant.apptextColor,
                                          ),
                                        ),
                                      ),
                                    )
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
                        Get.to(() => CheckOutScreen());
                      },
                      child: const Text(
                        "Checkout",
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
}
