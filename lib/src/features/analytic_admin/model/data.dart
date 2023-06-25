import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:ternav_icons/ternav_icons.dart';

import '../../../constants/colors.dart';
import '../model/course_model.dart';
import '../model/planing_model.dart';
import '../model/statistics_model.dart';
import '../controller/analytic_controller.dart';

class DataAnalyController extends GetxController {
  final List<Course> courses = [
    Course(
      text: "Seller",
      number: 0, // Set initial value to 0
      imageUrl: "images/pic/img1.png",
      percent: 75,
      backImage: tBox1,
      color: kDarkBlue,
    ),
    Course(
      text: "General",
      number: 0, // Set initial value to 0
      imageUrl: "images/pic/img2.png",
      percent: 50,
      backImage: tBox2,
      color: kOrange,
    ),
    Course(
      text: "Admin",
      number: 0, // Set initial value to 0
      imageUrl: "images/pic/img3.png",
      percent: 25,
      backImage: tBox3,
      color: kGreen,
    ),
  ];

  final AnalyticDashboardController analyticDashboardController =
      Get.put(AnalyticDashboardController());
  void updateCourseData() async {
    final List<Map<String, dynamic>> allRoleList =
        await analyticDashboardController.getAllRoleList().first;

    final int totalRoleCount = allRoleList.length;
    int totalCourseCount = 0;

    final List<Course> updatedCourses = [];

    for (final course in courses) {
      final String roleText = course.text;
      final int roleCount =
          allRoleList.where((role) => role['role'] == roleText).length;

      final updatedCourse = course.updateNumber(roleCount);
      updatedCourse.percent = (roleCount / totalRoleCount);

      updatedCourses.add(updatedCourse);

      totalCourseCount += roleCount;
    }

    final List<Course> finalCourses = updatedCourses.map((course) {
      return course.updateNumber(totalCourseCount);
    }).toList();

    courses.clear();
    courses.addAll(finalCourses);
  }
}

final List<Planing> planing = [
  Planing(
    heading: "Reading-Begineer Toipc 1",
    subHeading: "8:00 AM - 10:00 AM",
    color: kLightBlue,
    icon: const Icon(
      Icons.menu_book_outlined,
      color: kDarkBlue,
    ),
  ),
  Planing(
    heading: "Listening - Intermediate Topic 1",
    subHeading: "03:00 PM - 04:00 PM",
    color: const Color(0xffE2EDD2),
    icon: Icon(
      TernavIcons.lightOutline.hedphon,
      color: kGreen,
    ),
  ),
  Planing(
    heading: "Speaking - Beginner Topic 1",
    subHeading: "8:00 AM - 12:00 PM",
    color: const Color(0xffF9F0D3),
    icon: Icon(TernavIcons.lightOutline.volume_low, color: kYellow),
  ),
  Planing(
    heading: "Grammar - Intermediate Topic 2",
    subHeading: "8:00 AM - 12:00 PM",
    color: const Color(0xffF9E5D2),
    icon: Icon(
      TernavIcons.lightOutline.edit,
      color: kOrange,
    ),
  ),
  Planing(
    heading: "Listening - Intermediate Topic 1",
    subHeading: "8:00 AM - 12:00 PM",
    color: const Color(0xffE2EDD2),
    icon: Icon(
      TernavIcons.lightOutline.hedphon,
      color: kGreen,
    ),
  ),
  Planing(
    heading: "Grammar - Intermediate Topic 2",
    subHeading: "8:00 AM - 12:00 PM",
    color: const Color(0xffF9E5D2),
    icon: Icon(
      TernavIcons.lightOutline.edit,
      color: kOrange,
    ),
  ),
  Planing(
    heading: "Speaking - Beginner Topic 1",
    subHeading: "07:00 PM - 08:00 PM",
    color: const Color(0xffF9F0D3),
    icon: Icon(TernavIcons.lightOutline.volume_low, color: kYellow),
  ),
  Planing(
    heading: "Reading-Begineer Toipc 1",
    subHeading: "01:00 PM - 02:00 PM",
    color: kLightBlue,
    icon: const Icon(
      Icons.menu_book_outlined,
      color: kDarkBlue,
    ),
  ),
];

final List<Statistics> statistics = [
  Statistics(
    title: "Course Completed",
    number: "02",
  ),
  Statistics(
    title: "Total Points Gained",
    number: "250",
  ),
  Statistics(
    title: "Course In Progress ",
    number: "03",
  ),
  Statistics(
    title: "Tasks \nFinished",
    number: "05",
  )
];
