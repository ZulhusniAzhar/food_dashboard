// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../../item/model/item_model.dart';
import '../../../models/dashboard/postscard_model.dart';

class DashboardPostCard extends StatelessWidget {
  DashboardPostCard({
    super.key,
    required this.txtTheme,
    required this.uid,
    required this.postId,
    required this.itemID,
    required this.caption,
    required this.postPhoto,
    // required this.stockItem,
    // required this.timeStart,
    // required this.timeEnd,
    required this.venueBlock,
    required this.venueCollege,
    // required this.createdAt,
  });

  final TextTheme txtTheme;
  final String uid;
  final String postId;
  final String itemID;
  final String caption;
  final String postPhoto;
  // final int stockItem;
  // final DateTime timeStart;
  // final DateTime timeEnd;
  final String venueBlock;
  final String venueCollege;
  // final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tCardBgColor),
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
                        style: txtTheme.headline4,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Image.network(
                        postPhoto,
                        fit: BoxFit.cover,
                        height: 110,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   postId,
                        //   style: txtTheme.headline4,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        Text(
                          "$venueBlock,$venueCollege".toUpperCase(),
                          style: txtTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(width: tDashboardCardPadding * 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(tDashboardCardPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Manage",
                        style: txtTheme.bodyText2?.apply(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
