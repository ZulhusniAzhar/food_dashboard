import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../controller/post_controller.dart';
import 'widgets/post_form.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({
    required this.itemID,
  });

  final String itemID;

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
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
            "Create Post of Item",
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
            child: AddPostForm(),
          ),
        ),
      ),
    );
  }
}
