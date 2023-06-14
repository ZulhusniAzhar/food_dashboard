// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/authentication/models/user_model.dart';
import 'package:food_dashboard/src/features/report_ticket/model/reportticket_model.dart';
import 'package:food_dashboard/src/features/report_ticket/screen/reportticket_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../controller/report_ticket_controller.dart';

class ReportTicketListScreen extends StatelessWidget {
  ReportTicketListScreen({
    super.key,
  });
  final ReportTicketController reportController =
      Get.put(ReportTicketController());
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    double fontSizeInSp = 12.0;
    double fontSizeInPixels =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp;
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: isDark ? tWhiteColor : tDarkColor,
          ),
        ),
        title: Text(
          "Report Tickets",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List of Report Ticket Created!",
                style: txtTheme.bodyText2,
              ),
              Text(
                "Report to Seller",
                style: txtTheme.headline2,
              ),
              const SizedBox(
                height: tDashboardPadding,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display payments by month
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: reportController
                              .getUniqueMonthsBuyer()
                              .map((monthYear) {
                            List<ReportTicketModel> reportsForMonth =
                                reportController
                                    .getReportsByMonthBuyer(monthYear);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  monthYear,
                                  style: TextStyle(
                                    fontSize: fontSizeInPixels,
                                  ),
                                ),
                                ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: reportsForMonth.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    ReportTicketModel report =
                                        reportsForMonth[index];
                                    return TransactionCard(
                                        ticketforMonths:
                                            reportsForMonth[index]);
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.ticketforMonths,
  }) : super(key: key);

  final ReportTicketModel ticketforMonths;

  @override
  Widget build(BuildContext context) {
    double fontSizeInSp12 = 12.0;
    double fontSizeInPixels12 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp12;
    double fontSizeInSp14 = 14.0;
    double fontSizeInPixels14 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp14;
    double fontSizeInSp16 = 16.0;
    double fontSizeInPixels16 =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp16;
    double heightInUnits = 30.0;
    double heightInPixels =
        heightInUnits * MediaQuery.of(context).devicePixelRatio;
    String formattedDateTime =
        DateFormat('MMM d, hh:mm a').format(ticketforMonths.createdAt);

    final ReportTicketController rtController =
        Get.put(ReportTicketController());

    return GestureDetector(
      onTap: () {
        Get.to(
            () => ReportTicketDetailScreen(reportId: ticketforMonths.reportID));
      },
      child: SizedBox(
        height: heightInPixels,
        child: FutureBuilder<UserModel?>(
            future: rtController.getUserDetail(ticketforMonths.sellerID),
            builder: (context, AsyncSnapshot<UserModel?> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: const Color(0xFFF3F4F5),
                      backgroundImage:
                          NetworkImage(snapshot.data!.profilePhoto),
                    ),
                    const SizedBox(width: 17),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          child: Text(
                            snapshot.data!.fullName,
                            overflow: TextOverflow
                                .ellipsis, // Specify the overflow behavior
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: fontSizeInPixels14,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          formattedDateTime,
                          style: TextStyle(
                            fontSize: fontSizeInPixels12,
                            color: const Color(0xFF1A1A1A).withOpacity(0.4),
                          ),
                        ),
                        ticketforMonths.statusTicket == 0
                            ? Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Ongoing",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : ticketforMonths.statusTicket == 1
                                ? Container(
                                    width: 80,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Completed",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : ticketforMonths.statusTicket == 2
                                    ? Container(
                                        width: 120,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Admin Intervention",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Null",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 95,
                      child: Text(
                        "${ticketforMonths.problemCat}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSizeInPixels16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
