// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../item_detail_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.txtTheme,
    required this.name,
    required this.imageLink,
    required this.price,
    required this.category,
    required this.itemID,
    required this.path,
  });

  final TextTheme txtTheme;
  final String name;
  final String imageLink;
  final double price;
  final String category;
  final String itemID;
  final Widget path;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 175,
      child: GestureDetector(
        onTap: () => Get.to(() => path),
        child: SizedBox(
          width: 320,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 243, 232, 131)),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          name.toUpperCase(),
                          style: txtTheme.headline4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Image(
                          image: NetworkImage(imageLink),
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RM ${price.toStringAsFixed(2)}',
                            style: txtTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            category,
                            style: txtTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(width: tDashboardCardPadding * 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
