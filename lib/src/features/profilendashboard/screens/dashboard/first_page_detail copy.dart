import 'dart:io';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_info_section_component.dart';
import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/product_tile_section_component.dart';

import 'package:food_dashboard/src/features/post/screens/widgets/widget_detail/circle_product_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/imageutil.dart';

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
  final PostController postController = Get.put(PostController());
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
    postController.fetchData(widget.postID);
    postController.setSellerPhoneNo(widget.postID);
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

  void openWhatsapp({required String text, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // final postController = Get.put(PostController());
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                  Obx(() {
                    if (postController.postModelforDetail.value == null) {
                      return CircularProgressIndicator();
                    } else {
                      final yourPost = postController.postModelforDetail.value!;

                      String formattedDateStart =
                          DateFormat('EEEE, MMMM d, yyyy')
                              .format(yourPost.timeStart);
                      String formattedDateEnd = DateFormat('EEEE, MMMM d, yyyy')
                          .format(yourPost.timeEnd);
                      return Positioned(
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
                              Positioned(
                                top: 30,
                                left: 0,
                                right: 0,
                                child: ValueListenableBuilder(
                                  valueListenable: _imageHeight,
                                  builder: (context, value, _) {
                                    return SizedBox(
                                      height: _imageHeight.value,
                                      // child: Hero(
                                      //   // tag: widget.id,
                                      //   tag: Text("INI TAG"),
                                      //   child: Image.network(
                                      //     yourPost.postPhoto,
                                      //     fit: BoxFit.fitHeight,
                                      //   ),
                                      // ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                  _buildDiscoverDrawer(),
                ],
              ),
            ),
          ),
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
                  Obx(
                    () => SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          print(postController.sellerPhoneNumber.value);
                          // await FlutterLaunch.launchWhatsapp(
                          //   phone: '60197379794',
                          //   message:
                          //       'Hi Penjual,Saya mahu report berkenaan posting untuk hari ini, makanan saya basi',
                          // );\
                          openWhatsapp(
                              number: postController.sellerPhoneNumber.value,
                              text: 'Hello, this is a pre-filled message!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Send Report to Seller',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: tDarkColor,
                          ),
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
