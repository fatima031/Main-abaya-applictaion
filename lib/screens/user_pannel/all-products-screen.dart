// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_card/image_card.dart';


// import '../../models/productModels.dart';
// import '../../utils/app_constant.dart';

// class All_Products_Screen extends StatelessWidget {
//   const All_Products_Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: AppConstant.apptextColor),
//         backgroundColor: AppConstant.appMainColor,
//         title: const Text(
//           'All Products',
//           style: TextStyle(
//             color: AppConstant.apptextColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//           future: FirebaseFirestore.instance
//               .collection('products')
//               .where('isSale', isEqualTo: false)
//               .get(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text('Error'),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Container(
//                 height: Get.height / 5,
//                 child: const Center(child: CupertinoActivityIndicator()),
//               );
//             }
//             if (snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text("No products found!"),
//               );
//             }
//             if (snapshot.data != null) {
//               return GridView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   shrinkWrap: true,
//                   // ignore: prefer_const_constructors
//                   physics: BouncingScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 5,
//                       crossAxisSpacing: 5,
//                       childAspectRatio: 0.85),
//                   itemBuilder: (context, index) {
//                     final productData = snapshot.data!.docs[index];
//                     ProductModel productModel = ProductModel(
//                         productId: productData['productId'],
//                         categoryId: productData['categoryId'],
//                         productName: productData['categoryId'],
//                         categoryName: productData['categoryName'],
//                         salePrice: productData['salePrice'],
//                         fullPrice: productData['fullPrice'],
//                         productImage: productData['productImage'],
//                         deliveryTime: productData['deliveryTime'],
//                         isSale: productData['isSale'],
//                         productDescription: productData['productDescription'],
//                         createdAt: productData['createdAt'],
//                         updatedAt: productData['updatedAt']);

                   
//                     return GestureDetector(
//                       // onTap: () {
//                       //   Get.to(() => AllSingleCategoryProductScreen(
//                       //       categoryId: categoriesModel.categoryId));
//                       // },
//                       child: Container(
//                         width: 100,
//                         height: 30,
//                         padding: EdgeInsets.all(8),
//                         child: FillImageCard(
//                             borderRadius: 20.0,
//                             width: 130,
//                             heightImage: 140,
//                             imageProvider: CachedNetworkImageProvider(
//                                 productModel.productImage[0]),
//                             title: Center(
//                                 child: Text(
//                               productModel.productName,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 4,
//                               style: const TextStyle(fontSize: 12.0),
//                             )),
//                             footer: Center(
//                               child: Flexible(
//                                 child: Text(
//                                   "PKR: " + productModel.fullPrice,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             )),
//                       ),
//                     );
//                   });
//             }
//             return Container();
//           }),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:tqabayaapplication/models/productModels.dart';
import '../../utils/app_constant.dart';
import 'product-details-screen.dart';

class All_Products_Screen extends StatelessWidget {
  const All_Products_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = 0;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'All Products',
          style: TextStyle(
            color: AppConstant.apptextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('isSale', isEqualTo: false)
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
                height:   
                Get.height / 5,
                child:
                 const Center(child: CupertinoActivityIndicator()),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No products found!"),
              );
            }
            if (snapshot.data != null) {
              return  GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  // ignore: prefer_const_constructors
                  physics: BouncingScrollPhysics(),
                  gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 
                     _height * 0.00088,
                  ),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: productData['productId'],
                        categoryId: productData['categoryId'],
                        productName: productData['categoryId'],
                        categoryName: productData['categoryName'],
                        salePrice: productData['salePrice'],
                        fullPrice: productData['fullPrice'],
                        productImages: productData['productImages'],
                        deliveryTime: productData['deliveryTime'],
                        isSale: productData['isSale'],
                        productDescription: productData['productDescription'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt']);
                    return GestureDetector(
                      onTap: () {
                        Get.to(()=> ProductDetailsScreen(productModel: productModel));    
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          // border: Border.all()
                        ),
                        child: FillImageCard(
                          borderRadius: 20.0,
                          // height: 300,
                          // width: Get.width / 2.3,
                          // height: Get.height / 0.99,
                          width: MediaQuery.of(context).size.width,
                          heightImage: 180,
                          imageProvider: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            //   categoriesModel.categoryImg
                          ),
                          title:  Center(
                              child: Text(
                                "PKR: " + productModel.fullPrice,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12.0),
                              )),
                          // footer: Text(productModel.fullPrice, overflow: TextOverflow.ellipsis,),

                        ),

                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}