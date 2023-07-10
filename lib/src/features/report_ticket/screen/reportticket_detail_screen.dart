// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/model/item_model.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/form/form_header_widget.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../authentication/models/user_model.dart';
import '../controller/report_ticket_controller.dart';
import '../model/reportticket_model.dart';

class ReportTicketDetailScreen extends StatelessWidget {
  ReportTicketDetailScreen(
      {super.key, required this.reportId, required this.role});
  final String reportId;
  final String role;
  @override
  Widget build(BuildContext context) {
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
    final ReportTicketController rtController =
        Get.put(ReportTicketController());
    final txtTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: isDark ? tWhiteColor : tDarkColor,
            ),
          ),
          title: Text(
            "Issue Ticket Details",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<ReportTicketModel?>(
              future: rtController.getReportTicketDetail(reportId),
              builder: (context, AsyncSnapshot<ReportTicketModel?> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  String formattedDateTime = DateFormat('d MMM, hh:mm a')
                      .format(snapshot.data!.createdAt);
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: FormHeaderWidget(
                            image: tProblemSolve,
                            title: snapshot.data!.problemCat,
                            subTitle: "Issue Ticket Date: $formattedDateTime",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<UserModel?>(
                            future: role == "Seller"
                                ? rtController
                                    .getUserDetail(snapshot.data!.reporterID)
                                : rtController
                                    .getUserDetail(snapshot.data!.sellerID),
                            builder: (context,
                                AsyncSnapshot<UserModel?> sellersnapshot) {
                              if (sellersnapshot.hasError) {
                                return Text('Error: ${sellersnapshot.error}');
                              } else if (sellersnapshot.hasData) {
                                return FutureBuilder<PostModel?>(
                                    future: rtController
                                        .getPostDetail(snapshot.data!.postID),
                                    builder: (context,
                                        AsyncSnapshot<PostModel?>
                                            postsnapshot) {
                                      if (postsnapshot.hasError) {
                                        return Text(
                                            'Error: ${postsnapshot.error}');
                                      } else if (postsnapshot.hasData) {
                                        String postStartformattedDateTime =
                                            DateFormat('d MMM').format(
                                                postsnapshot.data!.timeStart);
                                        String postEndformattedDateTime =
                                            DateFormat('d MMM').format(
                                                postsnapshot.data!.timeEnd);

                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                role == "Buyer"
                                                    ? Text(
                                                        "Seller Name:",
                                                        style:
                                                            txtTheme.headline6,
                                                      )
                                                    : Text(
                                                        "Customer Name:",
                                                        style:
                                                            txtTheme.headline6,
                                                      ),
                                                const SizedBox(width: 5),
                                                role == "Buyer"
                                                    ? Text(
                                                        sellersnapshot
                                                            .data!.fullName,
                                                        style:
                                                            txtTheme.bodyText2,
                                                      )
                                                    : Text(
                                                        sellersnapshot
                                                            .data!.fullName,
                                                        style:
                                                            txtTheme.bodyText2,
                                                      ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                role == "Buyer"
                                                    ? Text(
                                                        "Seller Phone Number:",
                                                        style:
                                                            txtTheme.headline6,
                                                      )
                                                    : Text(
                                                        "Customer Phone Number:",
                                                        style:
                                                            txtTheme.headline6,
                                                      ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  sellersnapshot.data!.phoneNo,
                                                  style: txtTheme.bodyText2,
                                                ),
                                              ],
                                            ),
                                            FutureBuilder<ItemModel?>(
                                                future: rtController
                                                    .getItemDetail(postsnapshot
                                                        .data!.itemID),
                                                builder: (context,
                                                    AsyncSnapshot<ItemModel?>
                                                        itemsnapshot) {
                                                  if (itemsnapshot.hasError) {
                                                    return Text(
                                                        'Error: ${itemsnapshot.error}');
                                                  } else if (itemsnapshot
                                                      .hasData) {
                                                    return Row(
                                                      children: [
                                                        Text(
                                                          "Item Name:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          itemsnapshot
                                                              .data!.itemName,
                                                          style: txtTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                }),
                                            Row(
                                              children: [
                                                Text(
                                                  "Post Date Range:",
                                                  style: txtTheme.headline6,
                                                ),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                  child: Container(
                                                    width: 250,
                                                    child: Text(
                                                      "$postStartformattedDateTime - $postEndformattedDateTime",
                                                      // "da",
                                                      style: txtTheme.bodyText2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Comment:",
                                                  style: txtTheme.headline6,
                                                ),
                                                const SizedBox(width: 5),
                                                SizedBox(
                                                  width: 250,
                                                  child: Text(
                                                    snapshot.data!.comment,
                                                    style: txtTheme.bodyText2,
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            snapshot.data!.statusTicket == 0
                                                ? Container(
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Ongoing",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : snapshot.data!.statusTicket ==
                                                        1
                                                    ? Container(
                                                        width: 80,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : snapshot.data!
                                                                .statusTicket ==
                                                            2
                                                        ? Container(
                                                            width: 120,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors.red,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "Admin Intervention",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 80,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "Null",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            if (role != "Seller")
                                              snapshot.data!.statusTicket == 0
                                                  ? SizedBox(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          rtController
                                                              .changeStatusTicket(
                                                                  reportId, 1);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              tPrimaryColor,
                                                          side: BorderSide.none,
                                                          shape:
                                                              const StadiumBorder(),
                                                        ),
                                                        child: const Text(
                                                          "Problem Resolved",
                                                          style: TextStyle(
                                                              color:
                                                                  tDarkColor),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(height: 1),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            if (role != "Seller")
                                              snapshot.data!.statusTicket == 0
                                                  ? SizedBox(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          rtController
                                                              .changeStatusTicket(
                                                                  reportId, 2);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          side: BorderSide.none,
                                                          shape:
                                                              const StadiumBorder(),
                                                        ),
                                                        child: const Text(
                                                          "Seller Not Cooperating",
                                                          style: TextStyle(
                                                              color:
                                                                  tDarkColor),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(height: 1),
                                            if (role != "Seller")
                                              SizedBox(
                                                width: 200,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    openWhatsapp(
                                                        number: sellersnapshot
                                                            .data!.phoneNo,
                                                        text:
                                                            'Hello.\n Issue Ticket Details\n Category:${snapshot.data!.problemCat} \n Comment: ${snapshot.data!.comment}');
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    side: BorderSide.none,
                                                    shape:
                                                        const StadiumBorder(),
                                                  ),
                                                  child: const Text(
                                                    "WhatsApp Seller",
                                                    style: TextStyle(
                                                        color: tWhiteColor),
                                                  ),
                                                ),
                                              ),
                                            if (role != "Buyer")
                                              SizedBox(
                                                width: 200,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    openWhatsapp(
                                                        number: sellersnapshot
                                                            .data!.phoneNo,
                                                        text:
                                                            'Hello.\n Issue Ticket Details\n Category:${snapshot.data!.problemCat} \n Comment: ${snapshot.data!.comment}');
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    side: BorderSide.none,
                                                    shape:
                                                        const StadiumBorder(),
                                                  ),
                                                  child: const Text(
                                                    "WhatsApp Buyer",
                                                    style: TextStyle(
                                                        color: tWhiteColor),
                                                  ),
                                                ),
                                              )
                                          ],
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    });
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
