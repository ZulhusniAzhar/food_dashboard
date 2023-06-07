import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/widget/appbar.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/page.dart';
import '../../controllers/profile_controller.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key? key,
    required this.pageIdx,
  }) : super(key: key);
  int pageIdx;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    String roleCurrent = 'General';
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GetBuilder<ProfileController>(builder: (controller) {
      final profileController = Get.put(ProfileController());
      roleCurrent = profileController.currentRole.value;
      return Scaffold(
        appBar: DashboardAppBar(
          isDark: isDark,
        ),
        body: roleCurrent != 'Admin'
            ? pages[widget.pageIdx]
            : pagesAdmin[widget.pageIdx],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: tDarkColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orangeAccent,
          onTap: (idx) {
            setState(() {
              widget.pageIdx = idx;
            });
          },
          currentIndex: widget.pageIdx,
          items: [
            roleCurrent != 'Admin'
                ? const BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled, size: 30),
                    label: "Home",
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled, size: 30),
                    label: "Dashboard",
                  ),
            roleCurrent != 'Admin'
                ? const BottomNavigationBarItem(
                    icon: Icon(LineAwesomeIcons.money_bill, size: 30),
                    label: "Payment",
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled, size: 30),
                    label: "Role Change",
                  ),
            if (roleCurrent != 'Admin')
              const BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_rounded, size: 30),
                label: "QRCode",
              ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded, size: 30),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
