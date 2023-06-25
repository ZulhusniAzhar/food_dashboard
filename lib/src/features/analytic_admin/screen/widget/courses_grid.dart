import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/features/analytic_admin/controller/analytic_controller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../model/course_model.dart';
import '../../model/data.dart';

class CourseGrid extends StatefulWidget {
  const CourseGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseGrid> createState() => _CourseGridState();
}

class _CourseGridState extends State<CourseGrid> {
  final DataAnalyController dataController = Get.put(DataAnalyController());
  @override
  void initState() {
    super.initState();
    dataController
        .updateCourseData(); // Call the updateCourseData function here
  }

  @override
  Widget build(BuildContext context) {
    final AnalyticDashboardController analyticDashboardController =
        Get.put(AnalyticDashboardController());
    final List<Course> finalcourses = dataController.courses;
    return GridView.builder(
        itemCount: finalcourses.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(finalcourses[index].backImage),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        finalcourses[index].text,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        finalcourses[index].number.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 8,
                        animation: true,
                        animationDuration: 1500,
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: finalcourses[index].percent / 100,
                        progressColor: Colors.white,
                        center: Text(
                          "${finalcourses[index].percent.toString()}%",
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        // course[index].imageUrl,
                        tMakananRandom,
                        height: 110,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
