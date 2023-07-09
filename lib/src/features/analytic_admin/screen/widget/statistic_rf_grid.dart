import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../controller/analytic_controller.dart';
import '../../model/data.dart';

class StatisticsRFGrid extends StatelessWidget {
  const StatisticsRFGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnalyticDashboardController analyticDashboardController =
        Get.put(AnalyticDashboardController());

    return StreamBuilder(
      stream: analyticDashboardController.getAllIssueTicketList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> combinedList = snapshot.data!;

          final issueOngoingList =
              combinedList.where((item) => item['statusTicket'] == 0).toList();
          final issueAdminList =
              combinedList.where((item) => item['statusTicket'] == 2).toList();

          final ongoingCount = issueOngoingList.length;
          final adminIntrCount = issueAdminList.length;

          return Container(
            child: GridView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                childAspectRatio: 1,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StatisticBox(count: ongoingCount, title: "Ongoing");
                } else {
                  return StatisticBox(
                      count: adminIntrCount, title: "Need Admin Intervention");
                }
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class StatisticBox extends StatelessWidget {
  const StatisticBox({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kLightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xff8EA3B7),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 7,
                  decoration: BoxDecoration(
                    color: kDarkBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff006ED3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
