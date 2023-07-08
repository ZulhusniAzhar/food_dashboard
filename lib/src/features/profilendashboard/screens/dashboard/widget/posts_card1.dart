import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/first_page_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';

class DashboardPostCard1 extends StatelessWidget {
  DashboardPostCard1({
    super.key,
    required this.txtTheme,
    required this.uid,
    required this.postId,
    required this.itemID,
    required this.caption,
    // required this.postPhoto,
    required this.venueBlock,
    required this.venueCollege,
    required this.dateEnd,
  });
  final TextTheme txtTheme;
  final String uid;
  final String postId;
  final String itemID;
  final String caption;
  // final String postPhoto;
  final String venueBlock;
  final String venueCollege;
  final String dateEnd;
  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    return GestureDetector(
      onTap: () {
        Get.to(() => FirstPage(postID: postId));
      },
      child: FutureBuilder(
          future: postController.getItemDetailsbyPost(itemID),
          builder: (context, AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
            if (itemsnapshot.hasError) {
              return Text('Error: ${itemsnapshot.error}');
              // } else if (!itemsnapshot.hasData) {
              //   return Center(
              //     child: Text("No Data"),
              //   );
            } else if (itemsnapshot.hasData) {
              return Container(
                color: tWhiteColor,
                padding: const EdgeInsets.all(1),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 140,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${venueBlock.toUpperCase()},${venueCollege.toUpperCase()}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      itemsnapshot.data!['itemName'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: tSecondaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      caption.toLowerCase(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 68,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.06),
                                blurRadius: 8,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 150,
                              ),
                              SizedBox(
                                width: 60,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Text(
                                      'End: ${dateEnd}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: tSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 4),
                                    Text(
                                      'RM ${itemsnapshot.data!['price'].toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      left: -0,
                      child: SizedBox(
                        height: 140,
                        width: 120,
                        child: Hero(
                          tag: itemsnapshot.data!['itemPhoto'],
                          child: Image.network(
                            itemsnapshot.data!['itemPhoto'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
