// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({
    required this.itemID,
  });

  final String itemID;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Get.to(() => Dashboard());
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Item Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
          //       color: isDark ? tWhiteColor : tDarkColor),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Cubaan kedua",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "RM 12.00",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'NULL',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 32.0),
            GestureDetector(
              onTap: () {
                // Navigate to another page when the box is clicked
              },
              child: Container(
                width: double.infinity,
                height: 64.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            GestureDetector(
              onTap: () {
                // Navigate to another page when the box is clicked
              },
              child: Container(
                width: double.infinity,
                height: 64.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    'QR CODE',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
