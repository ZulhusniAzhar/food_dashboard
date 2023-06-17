// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// class ItemCard extends StatelessWidget {
//   const ItemCard({
//     super.key,
//     required this.txtTheme,
//     required this.name,
//     required this.imageLink,
//     required this.price,
//     required this.category,
//     required this.itemID,
//     required this.path,
//   });

//   final TextTheme txtTheme;
//   final String name;
//   final String imageLink;
//   final double price;
//   final String category;
//   final String itemID;
//   final Widget path;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 180,
//       child: GestureDetector(
//         onTap: () => Get.to(() => path),
//         child: SizedBox(
//           width: 320,
//           height: 190,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color.fromARGB(255, 243, 232, 131)),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: Text(
//                           name.toUpperCase(),
//                           style: txtTheme.headline4,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Flexible(
//                         child: Image(
//                           image: NetworkImage(imageLink),
//                           height: 100,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'RM ${price.toStringAsFixed(2)}',
//                             style: txtTheme.headline4,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             category,
//                             style: txtTheme.bodyText2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: tDashboardCardPadding * 2),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    // required this.title,
    // required this.color,
    // required this.count,
    required this.txtTheme,
    required this.name,
    required this.imageLink,
    required this.price,
    required this.category,
    required this.itemID,
    required this.path,
  });

  // final String title;

  // final Color color;
  // final int count;
  final TextTheme txtTheme;
  final String name;
  final String imageLink;
  final double price;
  final String category;
  final String itemID;
  final Widget path;

  @override
  Widget build(BuildContext context) {
    double getPropertionateScreenHeight(double inputHeight) {
      double screenHeight = MediaQuery.of(context).size.height;

      // 812 adalah layout height yang designer gunakan
      return (inputHeight / 812.0) * screenHeight;
    }

    double getPropertionateScreenWidht(double inputWidth) {
      double screenWidth = MediaQuery.of(context).size.width;

      // 812 adalah layout Width yang designer gunakan
      return (inputWidth / 390.0) * screenWidth;
    }

    TextStyle whiteTextStyle = GoogleFonts.firaSans(
      color: const Color(0xFFFFFFFF),
    );
    TextStyle primaryTextStyle = GoogleFonts.firaSans(
      color: const Color(0xFF031A2E),
    );
    return GestureDetector(
      onTap: () => Get.to(() => path),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: getPropertionateScreenWidht(188),
            width: getPropertionateScreenWidht(156),
            decoration: BoxDecoration(
              // color: tPrimaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageLink),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  tDarkColor
                      .withOpacity(0.85), // Adjust the opacity value as needed
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: getPropertionateScreenWidht(43),
                    height: getPropertionateScreenWidht(43),
                    decoration: const BoxDecoration(
                      color: tPrimaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: whiteTextStyle.copyWith(
                          fontSize: getPropertionateScreenWidht(14),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      child: Container(
                        width: getPropertionateScreenWidht(130),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name.toUpperCase(),
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.w900,
                                color: tDarkColor,
                                fontSize: getPropertionateScreenWidht(16),
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Set the desired overflow behavior
                              maxLines: 1,
                            ),
                            Text(
                              'RM ${price.toStringAsFixed(2)}',
                              style: primaryTextStyle.copyWith(
                                color: tWhiteColor,
                                fontSize: getPropertionateScreenWidht(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Image.network(imageLink),
        ],
      ),
    );
  }
}
