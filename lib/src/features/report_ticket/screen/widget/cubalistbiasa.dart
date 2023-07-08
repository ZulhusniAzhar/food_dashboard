// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/authentication/models/user_model.dart';
import 'package:food_dashboard/src/features/report_ticket/model/reportticket_model.dart';
import 'package:food_dashboard/src/features/report_ticket/screen/admin_detail_reportticket.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controller/report_ticket_controller.dart';

class ReportAdminTicketListScreen2 extends StatelessWidget {
  ReportAdminTicketListScreen2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final ReportTicketController reportController =
        Get.put(ReportTicketController());
    reportController.storeUserRole(reportController.getCurrentUserId());
    double fontSizeInSp = 12.0;
    double fontSizeInPixels =
        MediaQuery.of(context).textScaleFactor * fontSizeInSp;
    final txtTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          padding: const EdgeInsets.all(4),
          indicator: BoxDecoration(
            color: tPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: const Color(0xFF1A1A1A),
          labelColor: const Color(0xFF1A1A1A),
          tabs: const [
            Tab(
              child: Text("Admin Intervention"),
            ),
            Tab(
              child: Text("Ongoing"),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDashboardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "List of Issue Ticket!",
                      style: txtTheme.bodyText2,
                    ),
                    Text(
                      "Need Admin's Attention",
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
                            StreamBuilder(
                                stream: reportController
                                    .streamfetchTicketReportAdmin(),
                                builder: (context, reportAdminsnapshot) {
                                  if (reportAdminsnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (reportAdminsnapshot.hasError) {
                                    return Text(
                                        'Error: ${reportAdminsnapshot.error}');
                                  } else {
                                    List<ReportTicketModel> reportList =
                                        reportAdminsnapshot.data!;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount: reportList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            ReportTicketModel report =
                                                reportList[index];
                                            return TransactionCard(
                                                ticketforMonths:
                                                    reportList[index],
                                                role: "Admin");
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDashboardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "List of Issue Ticket!",
                      style: txtTheme.bodyText2,
                    ),
                    Text(
                      "Currently Ongoing",
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
                            StreamBuilder(
                                stream: reportController
                                    .streamfetchTicketReportOngoing(),
                                builder: (context, reportAdminsnapshot) {
                                  if (reportAdminsnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (reportAdminsnapshot.hasError) {
                                    return Text(
                                        'Error: ${reportAdminsnapshot.error}');
                                  } else {
                                    List<ReportTicketModel> reportList =
                                        reportAdminsnapshot.data!;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount: reportList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            ReportTicketModel report =
                                                reportList[index];
                                            return TransactionCard(
                                                ticketforMonths:
                                                    reportList[index],
                                                role: "Admin");
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.ticketforMonths,
    required this.role,
  }) : super(key: key);

  final ReportTicketModel ticketforMonths;
  final String role;

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
        Get.to(() =>
            AdminReportTicketDetailScreen(reportId: ticketforMonths.reportID));
      },
      child: SizedBox(
        height: heightInPixels,
        child: FutureBuilder<UserModel?>(
            future: rtController.getUserDetail(ticketforMonths.reporterID),
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
                            "By:  ${snapshot.data!.fullName}",
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
                    // const Spacer(),
                    SizedBox(
                      width: 60,
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
