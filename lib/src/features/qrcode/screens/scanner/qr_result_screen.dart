import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/controller/post_controller.dart';
import 'package:food_dashboard/src/features/qrcode/controllers/qr_code_controller.dart';
import 'package:food_dashboard/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../profilendashboard/screens/dashboard/first_page_detail.dart';

class QrResultScreen extends StatelessWidget {
  QrResultScreen({
    super.key,
    required this.widgetpostID,
    required this.widgetsellerID,
  });

  final String widgetpostID;
  final String widgetsellerID;

  @override
  Widget build(BuildContext context) {
    final RxInt postExistence = RxInt(0);
    final QRCodeController qrController = Get.put(QRCodeController());
    print("Ni awal:$postExistence");

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

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final AuthenticationRepository authRepo =
        Get.put(AuthenticationRepository());
    final PostController postController = Get.put(PostController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Get.to(() => Dashboard());
                Get.back();
              },
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: isDark ? tWhiteColor : tDarkColor)),
          title: Text(
            "Post List Result",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
            future: authRepo.getUserDetail(widgetsellerID),
            builder: (context, sellersnapshot) {
              if (sellersnapshot.hasError) {
                return Text('Error: ${sellersnapshot.error}');
              } else if (!sellersnapshot.hasData) {
                return const Center(
                  child: Text('No User Data'),
                  // child: CircularProgressIndicator(),
                );
              } else if (sellersnapshot.hasData) {
                print("ni dalam ayat:$postExistence");
                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            NetworkImage(sellersnapshot.data!.profilePhoto),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        sellersnapshot.data!.fullName,
                        style: const TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sellersnapshot.data!.college.toUpperCase(),
                        style: const TextStyle(
                            fontFamily: 'Source Sans Pro',
                            color: Colors.white,
                            fontSize: 14.0,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: 150.0,
                        child: Divider(
                          color: Colors.grey.shade100,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openWhatsapp(
                              text: "", number: sellersnapshot.data!.phoneNo);
                        },
                        child: Container(
                          width: 200,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Center(
                            child: Text(
                              "WhatsApp Seller",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: tDashboardCardPadding,
                      ),
                      // Center(
                      //   child: Text(
                      //     "Scanned Post Not Exist",
                      //     style: TextStyle(
                      //       color: postExistence.value == 1
                      //           ? Colors.transparent
                      //           : Colors.red,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      const Center(
                        child: Text(
                          "Scanned QR Code's post is the yellow ones",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: tDashboardCardPadding,
                      ),
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream:
                            postController.getPostListSeller(widgetsellerID),
                        builder: (context, postsnapshot) {
                          if (postsnapshot.hasError) {
                            return const Center(
                              child: Text("Error while fetching list"),
                            );
                          } else if (!postsnapshot.hasData) {
                            return const Center(
                              child: Text(
                                "No Post List",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (postsnapshot.hasData) {
                            final postDocs = postsnapshot.data!;

                            return Expanded(
                              // Wrap the ListView.builder with Expanded
                              child: ListView.builder(
                                itemCount: postDocs.length,
                                itemBuilder: ((context, index) {
                                  final postData = postDocs[index];
                                  final postId = postData['postID'].toString();
                                  final itemId = postData['itemID'].toString();
                                  final venueBlock =
                                      postData['venueBlock'].toString();
                                  final venueCollege =
                                      postData['venueCollege'].toString();
                                  // postExistence.value += 1;
                                  if (widgetpostID == postId) {
                                    postExistence.value = 1;
                                    print("ni kalau ada:$postExistence");
                                  }
                                  if (postExistence.value != 1) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('QR Code'),
                                            content: const Text(
                                                'The scanned Post does not exist anymore.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  }

                                  return FutureBuilder(
                                      future: postController
                                          .getItemDetailsbyPost(itemId),
                                      builder: (context, itemsnapshot) {
                                        if (itemsnapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                "Error while fetching list"),
                                          );
                                        } else if (!itemsnapshot.hasData) {
                                          // return const Center(
                                          //   child: Text(
                                          //     "No Post List",
                                          //     style: TextStyle(
                                          //       color: Colors.red,
                                          //       fontWeight: FontWeight.bold,
                                          //     ),
                                          //   ),
                                          // );
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (itemsnapshot.hasData) {
                                          return CardQRCodePost(
                                            itemName:
                                                itemsnapshot.data!['itemName'],
                                            venueBlock: venueBlock,
                                            venueCollege: venueCollege,
                                            postId: postId,
                                            widgetpostId: widgetpostID,
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      });
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
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class CardQRCodePost extends StatelessWidget {
  CardQRCodePost({
    super.key,
    required this.itemName,
    required this.postId,
    required this.venueBlock,
    required this.venueCollege,
    required this.widgetpostId,
  });
  String itemName;
  String postId;
  String venueBlock;
  String venueCollege;
  String widgetpostId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => FirstPage(
            // closeScreen: closeScanner,
            postID: postId,
          ),
        );
      },
      child: Card(
        color: widgetpostId != null && widgetpostId != postId
            ? tWhiteColor
            : tPrimaryColor,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 35.0,
        ),
        child: ListTile(
          leading: Icon(
            widgetpostId != postId ? Icons.arrow_right : Icons.qr_code_outlined,
            color: Colors.black,
            size: 40,
          ),
          title: Text(
            itemName,
            style: const TextStyle(
              color: tDarkColor,
              fontFamily: 'Source Sans Pro',
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            "$venueBlock,$venueCollege",
            style: const TextStyle(
              color: tDarkColor,
              fontFamily: 'Source Sans Pro',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
