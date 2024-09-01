import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';

import '../controllers/banners-controller.dart';

class bannerWidget extends StatefulWidget {
  const bannerWidget({super.key});

  @override
  State<bannerWidget> createState() => _bannerWidgetState();
}

class _bannerWidgetState extends State<bannerWidget> {
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  final BannersController bannersController = Get.put(BannersController());
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: Obx(() {
        return CarouselSlider(
          
            items: bannersController.bannerUrls
                .map((imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(

                        aspectRatio: 24/11,
                        child: CachedNetworkImage(
                          
                          imageUrl: imageUrls,
                          fit: BoxFit.cover,
                          // height: Get.height - 7,
                          width: Get.width - 10,
                          placeholder: (context, url) => const ColoredBox(
                            color: Colors.white,
                            child: Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1));
      }),
    );
  }
}
