import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_info_section_component.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_tile_section_component.dart';

import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/circle_product_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/imageutil.dart';
import '../../../post/screens/widgets/widget_detail/product_counter_widget.dart';

class FirstPage extends StatefulWidget {
  final String postID;

  final postController = Get.put(PostController());
  FirstPage({
    super.key,
    required this.postID,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();
  final ValueNotifier<double> _circleRadius = ValueNotifier<double>(180);
  final ValueNotifier<double> _imageHeight = ValueNotifier<double>(250);
  final double _minSize = 0.44;
  final double _maxSize = 0.76;
  final String itemName = '';

  final ValueNotifier<bool> _buttonLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollableController.addListener(_updateCircleRadius);
  }

  @override
  void dispose() {
    _scrollableController.removeListener(_updateCircleRadius);
    super.dispose();
  }

  void _updateCircleRadius() {
    double size = _scrollableController.size.clamp(_minSize, _maxSize);
    double normalizedSize = (size - _minSize) / (_maxSize - _minSize);
    _circleRadius.value = 180 - (normalizedSize * 100);
    _imageHeight.value = 250 - (normalizedSize * 100);
  }

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: tSecondaryColor,
      // appBar: AppBarWidget(
      //   onBackPressed: () => context.pop(),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(42),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: size.height * .5,
                      width: size.width,
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: ImageUtil.extractDominantColors(
                                // tOnBoardingImage2),
                                tSplashTopIcon),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data as List<Color>;
                                return ValueListenableBuilder(
                                    valueListenable: _circleRadius,
                                    builder: (context, value, _) {
                                      return Positioned(
                                        left: 0,
                                        right: 0,
                                        child: CircleProductWidget(
                                          radius: value,
                                          colors: data,
                                        ),
                                      );
                                    });
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          FutureBuilder(
                              future:
                                  postController.getPostDetail(widget.postID),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  DateTime dateStart =
                                      snapshot.data!['timeStart'].toDate();
                                  DateTime dateEnd =
                                      snapshot.data!['timeEnd'].toDate();

                                  String formattedDateStart =
                                      DateFormat('EEEE, MMMM d, yyyy')
                                          .format(dateStart);
                                  String formattedDateEnd =
                                      DateFormat('EEEE, MMMM d, yyyy')
                                          .format(dateEnd);
                                  return Positioned(
                                    top: 30,
                                    left: 0,
                                    right: 0,
                                    child: ValueListenableBuilder(
                                      valueListenable: _imageHeight,
                                      builder: (context, value, _) {
                                        return SizedBox(
                                          height: _imageHeight.value,
                                          child: Hero(
                                            // tag: widget.id,
                                            tag: Text("INI TAG"),
                                            child: Image.network(
                                              snapshot.data!['postPhoto'],
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                  _buildDiscoverDrawer(),
                ],
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         height: 60,
          //         width: size.width * .5,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Text(
          //               '\$30',
          //               style: GoogleFonts.poppins(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //                 color: tSecondaryColor,
          //               ),
          //             ),
          //             Container(
          //               width: 3,
          //               height: 3,
          //               decoration: BoxDecoration(
          //                 color: tSecondaryColor.withOpacity(.5),
          //                 shape: BoxShape.circle,
          //               ),
          //             ),
          //             Text(
          //               'ADD TO CART',
          //               style: GoogleFonts.poppins(
          //                 fontSize: 14,
          //                 color: tSecondaryColor,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  List<Widget> _sliverList(int size, int sliverChildCount) {
    String itemName = '';
    String itemIDPost = '';
    List<Widget> widgetList = [];
    final postController = Get.put(PostController());
    widgetList.add(
      SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
          maxHeight: 120,
          minHeight: 120,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            child: FutureBuilder(
                future: postController.getPostNItemDetails(widget.postID),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> postsnapshot) {
                  if (postsnapshot.hasError) {
                    return Text('Error: ${postsnapshot.error}');
                  } else if (postsnapshot.hasData) {
                    itemIDPost = postsnapshot.data!['itemID'];
                    return FutureBuilder(
                        future: postController
                            .getItemDetailsbyPost(postsnapshot.data!['itemID']),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                          if (itemsnapshot.hasError) {
                            return Text('Error: ${itemsnapshot.error}');
                          } else if (itemsnapshot.hasData) {
                            return Column(
                              children: [
                                Text(
                                  itemsnapshot.data!['itemName'].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: tSecondaryColor,
                                  ),
                                ),
                                Text(
                                  postsnapshot.data!['caption'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: tSecondaryColor.withOpacity(.5),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
    widgetList.add(
      SliverFixedExtentList(
        itemExtent: 80,
        delegate: SliverChildBuilderDelegate(
          childCount: sliverChildCount,
          (context, index) {
            return ProductTileSectionComponent(postID: widget.postID);
          },
        ),
      ),
    );

    widgetList.add(
      SliverFixedExtentList(
        itemExtent: 200,
        delegate: SliverChildBuilderDelegate(
          childCount: sliverChildCount,
          (context, index) {
            return ProductInfoSectionComponent(postID: widget.postID);
          },
        ),
      ),
    );
    widgetList.add(
      SliverFixedExtentList(
        itemExtent: 80,
        delegate: SliverChildBuilderDelegate(
          childCount: sliverChildCount,
          (context, index) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'REPORT',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: tDarkColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'BUY',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: tDarkColor,
                        ),
                      ),
                    ),
                  ),
                ]);
          },
        ),
      ),
    );

    return widgetList;
  }

  Widget _buildDiscoverDrawer() {
    return DraggableScrollableSheet(
      maxChildSize: 0.76,
      minChildSize: 0.44,
      initialChildSize: 0.44,
      snap: true,
      controller: _scrollableController,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42),
              topRight: Radius.circular(42),
              bottomLeft: Radius.circular(42),
              bottomRight: Radius.circular(42),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: _sliverList(10, 1),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
