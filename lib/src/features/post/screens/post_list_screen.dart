// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/screens/choose_item_screen.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/post_card.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../controller/post_controller.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final postController = Get.put(PostController());
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
          "Your Post",
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: postController.getPostListwithUid(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error while fetching list"),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Data"),
            );
          } else if (snapshot.hasData) {
            // final postDocs = snapshot.data!;
            List<Map<String, dynamic>> postDocs = snapshot.data!;
            postDocs.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
            return ListView.builder(
              itemCount: postDocs.length,
              itemBuilder: ((context, index) {
                final postData = postDocs[index];
                final postId = postData['postID'].toString();
                final itemId = postData['itemID'].toString();
                final caption = postData['caption'].toString();
                final postPhoto = postData['postPhoto'].toString();
                final stockItem = postData['stockItem'];
                DateTime timeStartdt = postData['timeStart'].toDate();
                DateTime timeEnddt = postData['timeEnd'].toDate();
                final timeStart = timeStartdt;
                final timeEnd = timeEnddt;
                final venueBlock = postData['venueBlock'].toString();
                final venueCollege = postData['venueCollege'].toString();
                DateTime createdAtdt = postData['createdAt'].toDate();
                final createdAt = createdAtdt;

                // final sideDish = itemData['sideDish'];

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: tDashboardCardPadding),
                    child: Center(
                      child: PostCard(
                        txtTheme: txtTheme,
                        postID: postId,
                        itemID: itemId,
                        caption: caption,
                        stockItem: stockItem,
                        // postPhoto: postPhoto,
                        timeStart: timeStart,
                        timeEnd: timeEnd,
                        venueBlock: venueBlock,
                        venueCollege: venueCollege,
                        createdAt: createdAt,
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ChooseItemScreen());
        },
        backgroundColor: isDark ? tWhiteColor : tPrimaryColor,
        child: IconButton(
          onPressed: () {
            // Get.to(() => const AddItemScreen());
            Get.to(() => const ChooseItemScreen());
          },
          icon: Icon(
            Icons.add,
            color: isDark ? tPrimaryColor : Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
