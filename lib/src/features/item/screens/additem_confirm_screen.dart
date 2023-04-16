import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import 'widget/item_form.dart';

class ItemConfirmScreen extends StatefulWidget {
  final File imageFile;
  final String imagePath;
  const ItemConfirmScreen({
    Key? key,
    required this.imageFile,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<ItemConfirmScreen> createState() => _ItemConfirmScreenState();
}

class _ItemConfirmScreenState extends State<ItemConfirmScreen> {
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
            "New Item (Image)",
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
