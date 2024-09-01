import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import '../../models/productModels.dart';
import '../../utils/app_constant.dart';

class AllFlashSaleProductScreen extends StatefulWidget {
  const AllFlashSaleProductScreen({super.key});

  @override
  State<AllFlashSaleProductScreen> createState() =>
      _AllFlashSaleProductScreenState();
}

class _AllFlashSaleProductScreenState extends State<AllFlashSaleProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'All Flash Sale Products',
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
              .where('isSale', isEqualTo: true)
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
                child: Text("No product found!"),
              );
            }
            if (snapshot.data != null) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  // ignore: prefer_const_constructors
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 0.85),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: productData['productId'],
                        categoryId: productData['categoryId'],
                        productName: productData['categoryId'],
                        categoryName: productData['categoryName'],
                        salePrice: productData['salePrice'],
                        fullPrice: productData['fullPrice'],
                        productImage: productData['productImage'],
                        deliveryTime: productData['deliveryTime'],
                        isSale: productData['isSale'],
                        productDescription: productData['productDescription'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt']);

                    // CategoriesModel categoriesModel = CategoriesModel(
                    //     categoryId: snapshot.data!.docs[index]['categoryId'],
                    //     categoryImg: snapshot.data!.docs[index]['categoryImg'],
                    //     categoryName: snapshot.data!.docs[index]
                    //         ['categoryName'],
                    //     createdOn: snapshot.data!.docs[index]['createdOn'],
                    //     updatedOn: snapshot.data!.docs[index]['updatedOn']);
                    return Row(
                      children: [
                        GestureDetector(
                          // onTap: () {
                          //   Get.to(() => AllSingleCategoryProductScreen(
                          //       categoryId: categoriesModel.categoryId));
                          // },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20.0,
                                width: 130,
                                heightImage: 140,
                                imageProvider: CachedNetworkImageProvider(
                                    productModel.productImage[0]),
                                title: Center(
                                    child: Text(
                                  productModel.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 12.0),
                                )),
                                // footer: Text(''),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
              // Container(
              //     height: Get.height / 5.5,
              //     child: ListView.builder(
              //         itemCount: snapshot.data!.docs.length,
              //         shrinkWrap: true,
              //         scrollDirection: Axis.horizontal,
              //         ));
            }
            return Container();
          }),
    );
  }
}
