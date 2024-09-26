// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../models/cartModels.dart';
import '../../models/productModels.dart';
import '../../utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Products Details",
          style: TextStyle(
            color: AppConstant.apptextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 60,
            ),
            // products images
            CarouselSlider(
                items: widget.productModel.productImages
                    .map((imageUrls) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 24 / 11, //w/h
                            child: CachedNetworkImage(
                              imageUrl: imageUrls,
                              fit: BoxFit.cover,
                              // height: Get.height - 10,
                              width: Get.width - 10,
                              placeholder: (context, url) => const ColoredBox(
                                color: Colors.white,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    aspectRatio: 2.5,
                    viewportFraction: 1)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.productModel.productName),
                              const Icon(Icons.favorite_outline)
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Category: " + widget.productModel.categoryName),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.productModel.isSale == true &&
                                      widget.productModel.salePrice != ''
                                  ? Text(
                                      "PKR: ${widget.productModel.salePrice}")
                                  : Text(
                                      "PKR: " + widget.productModel.fullPrice)
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(widget.productModel.productDescription)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Container(
                                width: Get.width / 3.0,
                                height: Get.height / 16,
                                decoration: const BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  // borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      sendMessageOnWhatsApp(
                                          productModel: widget.productModel);
                                    },
                                    child: const Text(
                                      "WhatsApp",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppConstant.apptextColor),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Material(
                              child: Container(
                                width: Get.width / 3.0,
                                height: Get.height / 16,
                                decoration: const BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  // borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: TextButton(
                                    onPressed: () async {
                                      // Get.to(() => Cart_Screen());
                                      await checkProductExistence(
                                          uId: user!.uid);
                                    },
                                    child: const Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppConstant.apptextColor),
                                    )),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp(
      {required ProductModel productModel}) async {
    final number = '03170261144';
    final message =
        'Hello Tahir Qadri Abaya App \n I want to know more about this product \n${productModel.productName} \n ${productModel.productId} \n ${productModel.productImages} \n ${productModel.fullPrice}';
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
    else{
      throw 'Could not launch $url';
    }
  }

 

//check product exist or not
  Future<void> checkProductExistence(
      {required String uId, int quantityIncreament = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncreament;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice,
      });
      print("Product Exits");
    } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uId)
          .set({'uId': uId, 'createdOn': DateTime.now()});
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(widget.productModel.isSale
            ? widget.productModel.salePrice
            : widget.productModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());

      print("Product Added");
    }
  }
}
