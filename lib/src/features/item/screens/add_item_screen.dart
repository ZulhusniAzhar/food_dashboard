// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/item/screens/widget/item_form.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Get.to(() => Dashboard());
                Get.back();
              },
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: isDark ? tWhiteColor : tDarkColor)),
          title: Text(
            "New Item (Food/Drink)",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
            //       color: isDark ? tWhiteColor : tDarkColor),
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: tFormHeight),
            padding: const EdgeInsets.all(tDefaultSize),
            child: AddItemForm(),
          ),
        ),
      ),
    );
  }
}
