// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../controller/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({required this.postID, super.key});

  final String postID;
  final PostController postController = Get.put(PostController());
  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to delete this item?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                // Delete the document and close the dialog
                postController.deletePost(postID);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final PostController postController = Get.put(PostController());
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
          "Post Details",
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
          child: FutureBuilder(
              future: postController.getPostDetail(postID),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  DateTime dateStart = snapshot.data!['timeStart'].toDate();
                  DateTime dateEnd = snapshot.data!['timeEnd'].toDate();

                  String formattedDateStart =
                      DateFormat('EEEE, MMMM d, yyyy').format(dateStart);
                  String formattedDateEnd =
                      DateFormat('EEEE, MMMM d, yyyy').format(dateEnd);

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 250,
                                height: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  snapshot.data!['postPhoto'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: tDashboardCardPadding),
                            Center(
                              child: Text(
                                snapshot.data!['caption'],
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Item Stock: ${snapshot.data!['stockItem'].toString()}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Start Date: $formattedDateStart',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'End Date: $formattedDateEnd',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Venue Block: ${snapshot.data!['venueBlock']}',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Venue College: ${snapshot.data!['venueCollege']}',
                              style: const TextStyle(
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
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Generate QR Code',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // GestureDetector(
                            //   onTap: () {
                            //     // Navigate to another page when the box is clicked
                            //   },
                            //   child: Container(
                            //     width: double.infinity,
                            //     height: 50.0,
                            //     decoration: BoxDecoration(
                            //       color: Colors.yellow,
                            //       borderRadius: BorderRadius.circular(16.0),
                            //     ),
                            //     child: const Center(
                            //       child: Text(
                            //         'Edit',
                            //         style: TextStyle(
                            //           fontSize: 18.0,
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.normal,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                showOptionsDialog(context);
                                // Navigate to another page when the box is clicked
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
