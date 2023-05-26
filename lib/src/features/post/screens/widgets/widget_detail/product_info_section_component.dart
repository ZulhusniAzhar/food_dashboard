import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'line_product_info_widget.dart';

class ProductInfoSectionComponent extends StatefulWidget {
  final String postID;
  const ProductInfoSectionComponent({
    super.key,
    required this.postID,
  });

  @override
  State<ProductInfoSectionComponent> createState() =>
      _ProductInfoSectionComponentState();
}

class _ProductInfoSectionComponentState
    extends State<ProductInfoSectionComponent> {
  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    // return Row(
    //   children: [
    return Padding(
      padding: const EdgeInsets.only(left: 52),
      child: FutureBuilder(
          future: postController.getPostNItemDetails(widget.postID),
          builder: (context, AsyncSnapshot<DocumentSnapshot> postsnapshot) {
            if (postsnapshot.hasError) {
              return Text('Error: ${postsnapshot.error}');
            } else if (postsnapshot.hasData) {
              return FutureBuilder(
                  future: postController
                      .getItemDetailsbyPost(postsnapshot.data!['itemID']),
                  builder:
                      (context, AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                    if (postsnapshot.hasError) {
                      return Text('Error: ${postsnapshot.error}');
                    } else if (postsnapshot.hasData) {
                      DateTime dateStart =
                          postsnapshot.data!['timeStart'].toDate();
                      DateTime dateEnd = postsnapshot.data!['timeEnd'].toDate();

                      String formattedDateStart =
                          DateFormat('EEEE, MMMM d, yyyy').format(dateStart);
                      String formattedDateEnd =
                          DateFormat('EEEE, MMMM d, yyyy').format(dateEnd);

                      String joinedIngredients =
                          itemsnapshot.data!['ingredient'].join(", ");
                      String joinedDish =
                          itemsnapshot.data!['sideDish'].join(", ");
                      return Column(
                        children: [
                          LineProductInfoWidget(
                            title: 'STOCK ITEM',
                            description:
                                postsnapshot.data!['stockItem'].toString(),
                          ),
                          SizedBox(height: 14),
                          LineProductInfoWidget(
                            title: 'INGREDIENT',
                            description: joinedIngredients,
                          ),
                          SizedBox(height: 14),
                          LineProductInfoWidget(
                            title: 'SIDE DISH',
                            description: joinedDish,
                          ),
                          SizedBox(height: 14),
                          LineProductInfoWidget(
                            title: 'DATE START',
                            description: formattedDateStart,
                          ),
                          SizedBox(height: 14),
                          LineProductInfoWidget(
                            title: 'DATE END',
                            description: formattedDateStart,
                          ),
                          SizedBox(height: 14),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
    //   ],
    // );
  }
}
