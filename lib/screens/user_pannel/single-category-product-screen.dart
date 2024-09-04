import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:tqabayaapplication/models/productModels.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

class AllSingleCategoryProductScreen extends StatefulWidget {
  String categoryId;
  AllSingleCategoryProductScreen({super.key, required this.categoryId});

  @override
  State<AllSingleCategoryProductScreen> createState() =>
      _AllSingleCategoryProductScreenState();
}

class _AllSingleCategoryProductScreenState
    extends State<AllSingleCategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'Products',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppConstant.apptextColor,
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('categoryId', isEqualTo: widget.categoryId)
              .get(),
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


              return 
              GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  // ignore: prefer_const_constructors
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 0.75
                      ),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: productData['productId'],
                        categoryId: productData['categoryId'],
                        productName: productData['productName'],
                        categoryName: productData['categoryName'],
                        salePrice: productData['salePrice'],
                        fullPrice: productData['fullPrice'],
                        productImage: productData['productImage'],
                        deliveryTime: productData['deliveryTime'],
                        isSale: productData['isSale'],
                        productDescription: productData['productDescription'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt']);
                    
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(),
                      child: FillImageCard(
                        borderRadius: 20.0,
                        // width: Get.width / 2.3,
                        // heightImage: Get.height / 11,
                        width: 130,
                        heightImage: 170,
                        imageProvider: CachedNetworkImageProvider(
                            productModel.productImage[0]),
                        title: Center(
                            child: Text(
                          productModel.productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 12.0),
                        )),
                        // footer: Text(''),
                      ),
                    );
                  }
                  );
            }
            return Container();
          }),
    );
  }
}
