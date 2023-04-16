// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_strings.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Icon(Icons.menu, color: isDark ? tWhiteColor : tDarkColor),
      title: Text(
        tAppName,
        style: Theme.of(context).textTheme.headline4,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark ? tSecondaryColor : tCardBgColor),
          // child: IconButton(
          //     onPressed: () {
          //       // // AuthenticationRepository.instance.logout();
          //       // Get.to(() => ProfileScreen());
          //     },
          //     icon: const Image(image: AssetImage(tImageBlank))),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
