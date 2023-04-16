// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/profilendashboard/models/dashboard/categories_model.dart';

import '../../../../../constants/colors.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final list = DashboardCategoriesModel.list;
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tDarkColor),
                  child: Center(
                    child: Text(
                      list[index].title,
                      style: txtTheme.headline6?.apply(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        // children: [
        //   SizedBox(
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 80,
        //           height: 45,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: tDarkColor),
        //           child: Center(
        //             child: Text(
        //               "KTDI",
        //               style: txtTheme.headline6?.apply(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
