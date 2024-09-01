import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:tqabayaapplication/screens/user_pannel/single-category-product-screen.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

import '../../controllers/category-model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'All Categories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppConstant.apptextColor,
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('Categories').get(),
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
                child: Text("No category found!"),
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
                    CategoriesModel categoriesModel = CategoriesModel(
                        categoryId: snapshot.data!.docs[index]['categoryId'],
                        categoryImg: snapshot.data!.docs[index]['categoryImg'],
                        categoryName: snapshot.data!.docs[index]
                            ['categoryName'],
                        createdOn: snapshot.data!.docs[index]['createdOn'],
                        updatedOn: snapshot.data!.docs[index]['updatedOn']);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AllSingleCategoryProductScreen(
                                categoryId: categoriesModel.categoryId));
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 200,
                                child: FillImageCard(
                                  borderRadius: 20.0,
                                  // height: 300,
                                  // width: Get.width / 2.3,
                                  // heightImage: Get.height / 6,
                                  width: 130,
                                  heightImage: 140,

                                  imageProvider: CachedNetworkImageProvider(
                                      categoriesModel.categoryImg),
                                  title: Center(
                                      child: Text(
                                    categoriesModel.categoryName,
                                    overflow: TextOverflow.ellipsis,
                                    // maxLines: 10,
                                    style: const TextStyle(fontSize: 12.0),
                                  )),
                                  // footer: Text(''),
                                ),
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
