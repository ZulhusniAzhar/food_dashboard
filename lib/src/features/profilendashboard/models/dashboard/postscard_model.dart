import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';

class DashboardPostCardModel {
  final String title;
  final String image;
  final String price;
  final String college;
  final VoidCallback? onPress;

  DashboardPostCardModel(
      this.title, this.image, this.price, this.college, this.onPress);

  static List<DashboardPostCardModel> list = [
    DashboardPostCardModel(
        "Nasi Lemak 1", tMakananRandom, "RM 2.50", "KTDI", null),
    DashboardPostCardModel(
        "Nasi Lemak 2", tMakananRandom, "RM 4.50", "KTR", null),
    DashboardPostCardModel(
        "Nasi Lemak 3", tMakananRandom, "RM 6.50", "KTHO", null),
    DashboardPostCardModel(
        "Nasi Lemak 3", tMakananRandom, "RM 6.50", "KTHO", null),
    DashboardPostCardModel(
        "Nasi Lemak 3", tMakananRandom, "RM 6.50", "KTHO", null),
    DashboardPostCardModel(
        "Nasi Lemak 3", tMakananRandom, "RM 6.50", "KTHO", null),
  ];
}
