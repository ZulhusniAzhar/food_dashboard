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

class AdminReportTicketDetailScreen extends StatelessWidget {
  AdminReportTicketDetailScreen({super.key, required this.reportId});
  final String reportId;

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
            "Report Ticket Details",
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
                    padding: const EdgeInsets.all(tDefaultSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: FormHeaderWidget(
                            image: tProblemSolve,
                            title: snapshot.data!.problemCat,
                            subTitle: "Report Date: $formattedDateTime",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<UserModel?>(
                            future: rtController
                                .getUserDetail(snapshot.data!.reporterID),
                            builder: (context,
                                AsyncSnapshot<UserModel?> reportersnapshot) {
                              if (reportersnapshot.hasError) {
                                return Text('Error: ${reportersnapshot.error}');
                              } else if (reportersnapshot.hasData) {
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
                                        return FutureBuilder<UserModel?>(
                                            future: rtController.getUserDetail(
                                                snapshot.data!.sellerID),
                                            builder: (context,
                                                AsyncSnapshot<UserModel?>
                                                    sellersnapshot) {
                                              if (sellersnapshot.hasError) {
                                                return Text(
                                                    'Error: ${sellersnapshot.error}');
                                              } else if (sellersnapshot
                                                  .hasData) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Buyer Name:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          reportersnapshot
                                                              .data!.fullName,
                                                          style: txtTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Buyer Phone Number:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          reportersnapshot
                                                              .data!.phoneNo,
                                                          style: txtTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(color: tDarkColor),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Seller Name:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          sellersnapshot
                                                              .data!.fullName,
                                                          style: txtTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Seller Phone Number:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          sellersnapshot
                                                              .data!.phoneNo,
                                                          style: txtTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(color: tDarkColor),
                                                    FutureBuilder<ItemModel?>(
                                                        future: rtController
                                                            .getItemDetail(
                                                                postsnapshot
                                                                    .data!
                                                                    .itemID),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    ItemModel?>
                                                                itemsnapshot) {
                                                          if (itemsnapshot
                                                              .hasError) {
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
                                                                      .data!
                                                                      .itemName,
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
                                                          "Date Post:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Container(
                                                          width: 200,
                                                          child: Text(
                                                            "$postStartformattedDateTime - $postEndformattedDateTime",
                                                            style: txtTheme
                                                                .bodyText2,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Comment:",
                                                          style: txtTheme
                                                              .headline6,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            snapshot
                                                                .data!.comment,
                                                            style: txtTheme
                                                                .bodyText2,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    snapshot.data!
                                                                .statusTicket ==
                                                            0
                                                        ? Container(
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
                                                                "Ongoing",
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
                                                        : snapshot.data!
                                                                    .statusTicket ==
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
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    "Completed",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
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
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Admin Intervention",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Null",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                    const SizedBox(
                                                      height: 40,
                                                    ),
                                                    snapshot.data!.statusTicket ==
                                                                0 ||
                                                            snapshot.data!
                                                                    .statusTicket ==
                                                                2
                                                        ? SizedBox(
                                                            width: 200,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                rtController
                                                                    .changeStatusTicket(
                                                                        reportId,
                                                                        1);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    tPrimaryColor,
                                                                side: BorderSide
                                                                    .none,
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
                                                        : const SizedBox(
                                                            height: 1),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          openWhatsapp(
                                                              number:
                                                                  sellersnapshot
                                                                      .data!
                                                                      .phoneNo,
                                                              text:
                                                                  'Hello, Im the representative of the Administrator.\n Issue Ticket Details\n Category:${snapshot.data!.problemCat} \n Comment: ${snapshot.data!.comment}');
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              tDarkColor,
                                                          side: BorderSide.none,
                                                          shape:
                                                              const StadiumBorder(),
                                                        ),
                                                        child: const Text(
                                                          "WhatsApp Seller",
                                                          style: TextStyle(
                                                              color:
                                                                  tWhiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          openWhatsapp(
                                                              number:
                                                                  reportersnapshot
                                                                      .data!
                                                                      .phoneNo,
                                                              text:
                                                                  'Hello, Im the representative of the Administrator.\n Issue Ticket Details\n Category:${snapshot.data!.problemCat} \n Comment: ${snapshot.data!.comment}');
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              tDarkColor,
                                                          side: BorderSide.none,
                                                          shape:
                                                              const StadiumBorder(),
                                                        ),
                                                        child: const Text(
                                                          "WhatsApp Buyer",
                                                          style: TextStyle(
                                                              color:
                                                                  tWhiteColor),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              } else {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            });
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
