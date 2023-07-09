import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../controller/analytic_controller.dart';
import '../../model/data.dart';

class StatisticsGrid extends StatelessWidget {
  const StatisticsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnalyticDashboardController analyticDashboardController =
        Get.put(AnalyticDashboardController());

    return StreamBuilder(
      stream: analyticDashboardController.getAllItemsList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> combinedList = snapshot.data!;

          final drinkList = combinedList
              .where((item) => item['category'] == "Drink")
              .toList();
          final foodList =
              combinedList.where((item) => item['category'] == "Food").toList();

          final drinkCount = drinkList.length;
          final foodCount = foodList.length;

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
                  return StatisticBox(count: drinkCount, title: "Drink");
                } else {
                  return StatisticBox(count: foodCount, title: "Food");
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
              "$title category",
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
