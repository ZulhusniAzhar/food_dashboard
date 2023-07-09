import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../controller/analytic_controller.dart';

class StatisticsPaymentGrid extends StatelessWidget {
  const StatisticsPaymentGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnalyticDashboardController analyticDashboardController =
        Get.put(AnalyticDashboardController());

    return StreamBuilder(
      stream: analyticDashboardController.getAllPaymentList(),
      builder: (context, allPaymentSnapshot) {
        if (allPaymentSnapshot.hasData) {
          final List<Map<String, dynamic>> allPaymentList =
              allPaymentSnapshot.data!;
          final allCount = allPaymentList.length;

          return StreamBuilder(
              stream: analyticDashboardController.getTodayPaymentList(),
              builder: (context, todayPaymentSnapshot) {
                if (todayPaymentSnapshot.hasData) {
                  final List<Map<String, dynamic>> todayPaymentList =
                      todayPaymentSnapshot.data!;

                  final todayCount = todayPaymentList.length;
                  return Container(
                    child: GridView.builder(
                      itemCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return StatisticBox(
                              count: todayCount, title: "Today's Transaction");
                        } else {
                          return StatisticBox(
                              count: allCount, title: "All Transaction");
                        }
                      },
                    ),
                  );
                } else if (allPaymentSnapshot.hasError) {
                  return Text('Error: ${allPaymentSnapshot.error}');
                } else {
                  return Container(
                    child: GridView.builder(
                      itemCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const StatisticBox(
                              count: 0, title: "Today's Transaction");
                        } else {
                          return StatisticBox(
                              count: allCount, title: "All Transaction");
                        }
                      },
                    ),
                  );
                }
              });
        } else if (allPaymentSnapshot.hasError) {
          return Text('Error: ${allPaymentSnapshot.error}');
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
