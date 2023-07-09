import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../controller/analytic_controller.dart';
import '../../model/chart_data.dart';

class BarChartContent extends StatelessWidget {
  const BarChartContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalyticDashboardController());
    controller.categorizePosts();
    List<BarChartGroupData> barChartGroupData = [];
    barChartGroupData = List.generate(7, (index) {
      int yValue = controller.categorizedLists[index].length;
      List rr = controller.categorizedLists;
      print("Updated barChartGroupData: $rr");
      return BarChartGroupData(
        x: index + 1,
        barRods: [
          BarChartRodData(
            y: yValue.toDouble(),
            width: 25,
            colors: [kLightBlue],
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value, _) => const TextStyle(
              fontSize: 12,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Mon';
                case 2:
                  return 'Tues';
                case 3:
                  return 'Wed';
                case 4:
                  return 'Thu';
                case 5:
                  return 'Fri';
                case 6:
                  return 'Sat';
                case 7:
                  return 'Sun';
              }
              return '';
            },
          ),
        ),
        borderData: FlBorderData(
            border: Border.all(color: Colors.transparent, width: 0)),
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 16,
        barGroups: barChartGroupData,
      ),
    );
  }
}
