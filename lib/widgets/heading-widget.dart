import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tqabayaapplication/utils/app_constant.dart';

class Heading_Widget extends StatelessWidget {
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback onTap;
  final String buttonText;
  const Heading_Widget(
      {super.key,
      required this.headingTitle,
      required this.headingSubtitle,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
                Text(
                 headingSubtitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppConstant.appSeconderyColor, width: 1.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: AppConstant.appSeconderyColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
