import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_dashboard/src/features/analytic_admin/controller/analytic_controller.dart';
import 'package:food_dashboard/src/features/analytic_admin/model/data.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import 'widget/activity_header.dart';
import 'widget/bar_chart.dart';
import 'widget/chart_container.dart';
import 'widget/courses_grid.dart';
import 'widget/planing_grid.dart';
import 'widget/planing_header.dart';
import 'widget/statistics_grid.dart';

class DashboardAnalytics extends StatelessWidget {
  const DashboardAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "User Info",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "View All",
                //   style: TextStyle(color: kDarkBlue),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CourseGrid(),
            const SizedBox(
              height: 20,
            ),
            // const PlaningHeader(),
            // const SizedBox(
            //   height: 15,
            // ),
            // const PlaningGrid(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Statistics",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const StatisticsGrid(),
            const SizedBox(
              height: 15,
            ),
            const ActivityHeader(),
            const ChartContainer(chart: BarChartContent())
          ],
        ),
      ),
    );
  }
}
