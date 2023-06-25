// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../post/controller/post_controller.dart';
import 'categories.dart';
import 'posts_card1.dart';
import 'package:intl/intl.dart';

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

            Obx(
              () => StreamBuilder<List<Map<String, dynamic>>>(
                stream: postController.getPostListDashboardwithCollege(
                    postController.selectedCategory.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error while fetching list"),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text("No Data"));
                  } else if (snapshot.hasData) {
                    final postDashboardDocs = snapshot.data;
                    // final filteredList = snapshot.data
                    //     ?.where((postData) =>
                    //         postData['venueCollege'] ==
                    //         postController.selectedCategory.value)
                    //     .toList();
                    return SizedBox(
                      height: 430,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: postDashboardDocs!.length,
                        itemBuilder: ((context, index) {
                          final postData = postDashboardDocs[index];
                          final uid = postData['uid'].toString();
                          final postId = postData['postID'].toString();
                          final itemId = postData['itemID'].toString();
                          final caption = postData['caption'].toString();
                          // final postPhoto = postData['postPhoto'].toString();
                          final venueBlock = postData['venueBlock'].toString();
                          final venueCollege =
                              postData['venueCollege'].toString();
                          DateTime dateStart = postData['timeEnd'].toDate();

                          String formattedDateStart =
                              DateFormat('MMMM d').format(dateStart);

                          return SingleChildScrollView(
                            child: Container(
                              // padding: const EdgeInsets.all(8),
                              child: Center(
                                child: DashboardPostCard1(
                                  txtTheme: txtTheme,
                                  uid: uid,
                                  postId: postId,
                                  itemID: itemId,
                                  caption: caption,
                                  // postPhoto: postPhoto,
                                  venueBlock: venueBlock,
                                  venueCollege: venueCollege,
                                  dateEnd: formattedDateStart,
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
            ),
          ],
        ),
      ),
    );
  }
}
