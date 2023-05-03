// ignore_for_file: deprecated_member_use

import 'dart:ffi';
import 'package:food_dashboard/src/features/post/screens/post_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.txtTheme,
    required this.postID,
    required this.itemID,
    required this.caption,
    required this.stockItem,
    required this.postPhoto,
    required this.timeStart,
    required this.timeEnd,
    required this.venueBlock,
    required this.venueCollege,
    required this.createdAt,
  });

  final TextTheme txtTheme;
  final String itemID;
  final String postID;
  final String caption;
  final String postPhoto;
  final int stockItem;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String venueBlock;
  final String venueCollege;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    String formattedDateStart =
        DateFormat('EEEE, MMMM d, yyyy').format(timeStart);
    String formattedDateEnd = DateFormat('EEEE, MMMM d, yyyy').format(timeEnd);
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () => Get.to(() => PostDetailScreen(postID: postID)),
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
                          caption.toUpperCase(),
                          style: txtTheme.subtitle1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Image(
                          image: NetworkImage(postPhoto),
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
                            "Item Stock: ${stockItem.toString()}",
                            style: txtTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Start Date: $formattedDateStart",
                            style: txtTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "End Date: $formattedDateEnd",
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
