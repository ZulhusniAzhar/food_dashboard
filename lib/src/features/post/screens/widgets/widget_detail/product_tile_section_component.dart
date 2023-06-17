import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/post_controller.dart';
import 'tile_product_info_widget.dart';

class ProductTileSectionComponent extends StatefulWidget {
  final String postID;
  const ProductTileSectionComponent({
    super.key,
    required this.postID,
  });

  @override
  State<ProductTileSectionComponent> createState() =>
      _ProductTileSectionComponentState();
}

class _ProductTileSectionComponentState
    extends State<ProductTileSectionComponent> {
  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    return FutureBuilder(
        future: postController.getPostNItemDetails(widget.postID),
        builder: (context, AsyncSnapshot<DocumentSnapshot> postsnapshot) {
          if (postsnapshot.hasError) {
            return Text('Error: ${postsnapshot.error}');
          } else if (!postsnapshot.hasData) {
            return Center(
              child: Text("No Data"),
            );
          } else if (postsnapshot.hasData) {
            return FutureBuilder(
                future: postController
                    .getItemDetailsbyPost(postsnapshot.data!['itemID']),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                  if (itemsnapshot.hasError) {
                    return Text('Error: ${itemsnapshot.error}');
                  } else if (!itemsnapshot.hasData) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else if (itemsnapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TileProductInfoWidget(
                          title: 'CATEGORY',
                          description:
                              itemsnapshot.data!['category'].toString(),
                          color: const Color(0xFF64FFDA),
                        ),
                        TileProductInfoWidget(
                          title: 'PRICE',
                          description:
                              'RM ${itemsnapshot.data!['price'].toStringAsFixed(2)}',
                          color: const Color(0xff7378ff),
                        ),
                        TileProductInfoWidget(
                          title: 'COLLEGE',
                          description:
                              postsnapshot.data!['venueCollege'].toString(),
                          color: const Color(0xffff9b9b),
                        ),
                        TileProductInfoWidget(
                          title: 'BLOCK',
                          description:
                              postsnapshot.data!['venueBlock'].toString(),
                          color: const Color(0xffffe55e),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
