import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/models/productModels.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
                items: widget.productModel.productImage
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
                              Icon(Icons.favorite_outline)
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
                          child: Text("PKR: " + widget.productModel.fullPrice)),
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
                                decoration: BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  // borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      // Get.to(() => SignIn());
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
                            SizedBox(
                              width: 5.0,
                            ),
                            Material(
                              child: Container(
                                width: Get.width / 3.0,
                                height: Get.height / 16,
                                decoration: BoxDecoration(
                                  color: AppConstant.appMainColor,
                                  // borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      // Get.to(() => SignIn());
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
}
