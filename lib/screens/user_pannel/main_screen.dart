import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/screens/user_pannel/all-products-screen.dart';
import 'package:tqabayaapplication/screens/user_pannel/cart-screen.dart';
import '../../utils/app_constant.dart';
import '../../widgets/all-products-widget.dart';
import '../../widgets/category-widget.dart';
import '../../widgets/custom-banners.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/flash-sale.dart';
import '../../widgets/heading-widget.dart';
import 'all-categories-screen.dart';
import 'all-flash-sale-product-scree.dart';

class Main_screen extends StatelessWidget {
  const Main_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(color: AppConstant.apptextColor),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => const Cart_Screen());
              },
              child: const Icon(Icons.shopping_cart_checkout))
        ],
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90,
              ),
              //banners
              bannerWidget(),
              //heading
              Heading_Widget(
                headingTitle: 'Categories',
                headingSubtitle: 'According to your budget',
                onTap: () => Get.to(() => AllCategoriesScreen()),
                buttonText: 'See More >',
              ),
              CategoryWidget(),
              //heading
              Heading_Widget(
                headingTitle: 'Flash Sale',
                headingSubtitle: 'According to your budget',
                onTap: () {
                  Get.to(() => AllFlashSaleProductScreen());
                },
                buttonText: 'See More >',
              ),
              Flash_sale_widget(),

              Heading_Widget(
                headingTitle: 'All Products',
                headingSubtitle: 'According to your budget',
                onTap: () {
                  Get.to(() => All_Products_Screen());
                },
                buttonText: 'See More >',
              ),
              All_Product_widget(),
            ],
          ),
        ),
      ),
    );
  }
}
