// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../post/controller/post_controller.dart';
import 'categories.dart';
import 'posts_card1.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(tDashboardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tDashboardTitle,
              style: txtTheme.bodyText2,
            ),
            Text(
              tDashboardHeading,
              style: txtTheme.headline2,
            ),
            const SizedBox(
              height: tDashboardPadding,
            ),

            //search bar
            // Container(
            //   decoration: const BoxDecoration(
            //     border: Border(
            //         left: BorderSide(
            //       width: 4,
            //     )),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(tDashboardSearch,
            //           style: txtTheme.headline2
            //               ?.apply(color: Colors.grey.withOpacity(0.5))),
            //       const Icon(
            //         Icons.search,
            //         size: 25,
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: tDashboardPadding,
            // ),

            //Categories
            DashboardCategories(txtTheme: txtTheme),
            const SizedBox(
              height: tDashboardPadding,
            ),

            //Banners
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: tCardBgColor),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 10, vertical: 20),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: const [
            //                 Flexible(
            //                     child: Image(
            //                         image: AssetImage(tGoogleLogoImage))),
            //                 Flexible(
            //                     child: Image(
            //                         image: AssetImage(tForgetPassImage))),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 25,
            //             ),
            //             Text(
            //               tDashboardBannerTitle1,
            //               style: txtTheme.headline4,
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             Text(
            //               tDashboardBannerSubTitle,
            //               style: txtTheme.bodyText2,
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: tDashboardCardPadding,
            //     ),
            //     Expanded(
            //       child: Column(
            //         children: [
            //           Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: tCardBgColor),
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: const [
            //                     Flexible(
            //                         child: Image(
            //                             image: AssetImage(tGoogleLogoImage))),
            //                     Flexible(
            //                         child: Image(
            //                             image: AssetImage(tForgetPassImage))),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 25,
            //                 ),
            //                 Text(
            //                   tDashboardBannerTitle2,
            //                   style: txtTheme.headline4,
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 Text(
            //                   tDashboardBannerSubTitle,
            //                   style: txtTheme.bodyText2,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            //yang bawah ni mmg lama dah comment jadi uncomment yang atas dia je
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 230,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: tCardBgColor),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 100, vertical: 20),
            //         child: Center(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: const [
            //                   Flexible(
            //                       child: Image(
            //                     image: AssetImage(tGoogleLogoImage),
            //                     height: 100.0,
            //                   )),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 25,
            //               ),
            //               Text(
            //                 tDashboardBannerTitle2,
            //                 style: txtTheme.headline4,
            //                 maxLines: 2,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //               Text(
            //                 tDashboardBannerSubTitle,
            //                 style: txtTheme.bodyText2,
            //                 maxLines: 1,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: tDashboardCardPadding,
            //       ),
            //       Container(
            //         height: 100,
            //         color: Colors.grey[200],
            //         child: const Center(
            //           child: Text(
            //             'Container 2',
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            StreamBuilder<List<Map<String, dynamic>>>(
              stream: postController.getPostListDashboard(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error while fetching list"),
                  );
                } else if (snapshot.hasData) {
                  final postDashboardDocs = snapshot.data!;
                  return SizedBox(
                    height: 430,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: postDashboardDocs.length,
                      itemBuilder: ((context, index) {
                        final postData = postDashboardDocs[index];
                        final uid = postData['uid'].toString();
                        final postId = postData['postID'].toString();
                        final itemId = postData['itemID'].toString();
                        final caption = postData['caption'].toString();
                        final postPhoto = postData['postPhoto'].toString();
                        // final stockItem = postData['stockItem'];
                        // final timeStart = postData['timeStart'];
                        // final timeEnd = postData['timeEnd'];
                        final venueBlock = postData['venueBlock'].toString();
                        final venueCollege =
                            postData['venueCollege'].toString();
                        // final createdAt = postData['createdAt'];

                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(tDashboardPadding),
                            child: Center(
                              child: DashboardPostCard1(
                                txtTheme: txtTheme,
                                uid: uid,
                                postId: postId,
                                itemID: itemId,
                                caption: caption,
                                postPhoto: postPhoto,
                                // stockItem: stockItem as int,
                                // timeStart: timeStart as DateTime,
                                // timeEnd: timeEnd as DateTime,
                                venueBlock: venueBlock,
                                venueCollege: venueCollege,
                                // createdAt: createdAt as DateTime,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
