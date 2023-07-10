// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/set_amount_buy.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_info_section_component.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_tile_section_component.dart';

import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/circle_product_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/imageutil.dart';
import '../../../report_ticket/screen/create_report_screen.dart';

class FirstPage extends StatefulWidget {
  final String postID;

  final PostController postController = Get.put(PostController());

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
  // final PostController postController = Get.put(PostController());
  final ValueNotifier<double> _circleRadius = ValueNotifier<double>(180);
  final ValueNotifier<double> _imageHeight = ValueNotifier<double>(250);
  final double _minSize = 0.44;
  final double _maxSize = 0.76;
  final String itemName = '';

  // final ValueNotifier<bool> _buttonLoading = ValueNotifier(false);

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

  Widget _container(Widget child) {
    return Container(
      height: 20.0,
      width: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tWhiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: tDarkColor.withOpacity(0.15),
            offset: const Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final postController = Get.put(PostController());

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: tSecondaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left,
                color: isDark ? tWhiteColor : tDarkColor)),
        title: Text(
          "Post Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        // actions: [
        //   IconButton(
        //     color: Colors.redAccent,
        //     icon: const Icon(Icons.report_outlined),
        //     tooltip: 'Report Post',
        //     onPressed: () {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(content: Text('Report This Post')));
        //     },
        //   ),
        // ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: FutureBuilder(
          future: postController.getPostDetail(widget.postID),
          builder: (context, AsyncSnapshot<DocumentSnapshot> postsnapshot) {
            if (postsnapshot.hasError) {
              return Text('Error: ${postsnapshot.error}');
            } else if (!postsnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (postsnapshot.hasData) {
              DateTime dateStart = postsnapshot.data!['timeStart'].toDate();
              DateTime dateEnd = postsnapshot.data!['timeEnd'].toDate();

              String formattedDateStart =
                  DateFormat('EEEE, MMMM d, yyyy').format(dateStart);
              String formattedDateEnd =
                  DateFormat('EEEE, MMMM d, yyyy').format(dateEnd);
              return Column(
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
                      child: FutureBuilder(
                          future: postController.getItemDetailsbyPost(
                              postsnapshot.data!['itemID']),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                            if (itemsnapshot.hasError) {
                              return Text('Error: ${itemsnapshot.error}');
                            } else if (!itemsnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (itemsnapshot.hasData) {
                              return Stack(
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
                                            future:
                                                ImageUtil.extractDominantColors(
                                              itemsnapshot.data!['itemPhoto'],
                                            ),
                                            builder: (context, colorsnapshot) {
                                              if (colorsnapshot.hasError) {
                                                return const Center(
                                                  child:
                                                      Text("There is an error"),
                                                );
                                              } else if (!colorsnapshot
                                                  .hasData) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (colorsnapshot
                                                  .hasData) {
                                                final data = colorsnapshot.data
                                                    as List<Color>;
                                                return ValueListenableBuilder(
                                                    valueListenable:
                                                        _circleRadius,
                                                    builder:
                                                        (context, value, _) {
                                                      return Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        child:
                                                            CircleProductWidget(
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
                                          Positioned(
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
                                                    tag: const Text("INI TAG"),
                                                    child: Image.network(
                                                      itemsnapshot
                                                          .data!['itemPhoto'],
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _buildDiscoverDrawer(),
                                ],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
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
                  } else if (!postsnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (postsnapshot.hasData) {
                    return FutureBuilder(
                        future: postController
                            .getItemDetailsbyPost(postsnapshot.data!['itemID']),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                          if (itemsnapshot.hasError) {
                            return Text('Error: ${itemsnapshot.error}');
                          } else if (!itemsnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
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
        itemExtent: 225,
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
            return FutureBuilder(
                future: postController.getPostNItemDetails(widget.postID),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> postsnapshot) {
                  if (postsnapshot.hasError) {
                    return Text('Error: ${postsnapshot.error}');
                  } else if (!postsnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (postsnapshot.hasData) {
                    String userID = postsnapshot.data!['uid'];
                    DateTime dateStart =
                        postsnapshot.data!['timeStart'].toDate();
                    String formattedDateStart =
                        DateFormat('EEEE, d MMMM,yyyy').format(dateStart);
                    DateTime dateEnd = postsnapshot.data!['timeEnd'].toDate();
                    String formattedDateEnd =
                        DateFormat('EEEE, d MMMM,yyyy').format(dateEnd);
                    return FutureBuilder(
                        future: postController
                            .getItemDetailsbyPost(postsnapshot.data!['itemID']),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> itemsnapshot) {
                          if (itemsnapshot.hasError) {
                            return Text('Error: ${itemsnapshot.error}');
                          } else if (!itemsnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (itemsnapshot.hasData) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FutureBuilder(
                                      future: postController
                                          .getSellerPhoneNo(userID),
                                      builder: (context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              usersnapshot) {
                                        if (usersnapshot.hasError) {
                                          return Text(
                                              'Error: ${usersnapshot.error}');
                                        } else if (!usersnapshot.hasData) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (usersnapshot.hasData) {
                                          // print(usersnapshot.data!['phoneNo']);
                                          return SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(() => CreateReportScreen(
                                                      sellerID: postsnapshot
                                                          .data!['uid'],
                                                      postId: postsnapshot
                                                          .data!['postID'],
                                                      sellerPhoneNo:
                                                          usersnapshot
                                                              .data!['phoneNo'],
                                                      fullNameSeller:
                                                          usersnapshot.data![
                                                              'fullName'],
                                                      itemName: itemsnapshot
                                                          .data!['itemName'],
                                                      dateStartBuy:
                                                          formattedDateStart,
                                                      dateStartEnd:
                                                          formattedDateEnd,
                                                    ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.redAccent,
                                                side: BorderSide.none,
                                                shape: const StadiumBorder(),
                                              ),
                                              child: Text(
                                                'Make Report',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: tDarkColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      }),
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // BuyItemStockScreen
                                        //     .buildShowModalBottomSheet(context);
                                        Get.to(() => SetAmountItemStockScreen(
                                              itemPhoto: itemsnapshot
                                                  .data!['itemPhoto'],
                                              price:
                                                  itemsnapshot.data!['price'],
                                              caption:
                                                  postsnapshot.data!['caption'],
                                              itemName: itemsnapshot
                                                  .data!['itemName'],
                                              itemStock: postsnapshot
                                                  .data!['stockItem'],
                                              sellerID:
                                                  postsnapshot.data!['uid'],
                                              postID:
                                                  postsnapshot.data!['postID'],
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: tPrimaryColor,
                                        side: BorderSide.none,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: Text(
                                        'Purchase',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: tDarkColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
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
