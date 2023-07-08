import 'package:flutter/material.dart';

class DashboardCategoriesModel {
  final String title;
  final VoidCallback? onPress;

  DashboardCategoriesModel(this.title, this.onPress);

  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel("ALL", null),
    DashboardCategoriesModel("KTDI", null),
    DashboardCategoriesModel("KTR", null),
    DashboardCategoriesModel("KTHO", null),
    DashboardCategoriesModel("KRP", null),
    DashboardCategoriesModel("KTC", null),
    DashboardCategoriesModel("KTF", null),
    DashboardCategoriesModel("KDSE", null),
  ];
}
