// ignore_for_file: deprecated_member_use

import 'package:food_dashboard/src/features/post/screens/post_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.txtTheme,
    required this.postID,
    required this.itemID,
    required this.caption,
    required this.stockItem,
    // required this.postPhoto,
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
  // final String postPhoto;
  final int stockItem;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String venueBlock;
  final String venueCollege;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    String formattedDateStart = DateFormat('MMMM d').format(timeStart);
    String formattedDateEnd = DateFormat('MMMM d, yyyy').format(timeEnd);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            // '${venueBlock},${venueCollege}',
            '${formattedDateStart} - ${formattedDateEnd}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
          '${caption} \n\n${venueBlock},${venueCollege}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Get.to(() => PostDetailScreen(postID: postID)),
      ),
    );
  }
}
