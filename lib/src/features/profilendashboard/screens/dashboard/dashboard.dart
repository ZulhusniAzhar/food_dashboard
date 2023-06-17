import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/widget/appbar.dart';
import 'package:food_dashboard/src/repository/authentication_repository/authentication_repository.dart';
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
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GetBuilder<ProfileController>(builder: (controller) {
      final profileController = Get.put(ProfileController());
      final AuthenticationRepository authRepo =
          Get.put(AuthenticationRepository());
      return Obx(
        () => Scaffold(
          appBar: DashboardAppBar(
            isDark: isDark,
          ),
          body: profileController.currentRole.value != 'Admin'
              ? pages[widget.pageIdx]
              : pagesAdmin[widget.pageIdx],
          bottomNavigationBar: profileController.currentRole.value != 'Admin'
              ? BottomNavigationBar(
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
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled, size: 30),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineAwesomeIcons.money_bill, size: 30),
                      label: "Payment",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code_2_rounded, size: 30),
                      label: "QRCode",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_rounded, size: 30),
                      label: "Profile",
                    ),
                  ],
                )
              : BottomNavigationBar(
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
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled, size: 30),
                      label: "Dashboard",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled, size: 30),
                      label: "Role Change",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_rounded, size: 30),
                      label: "Profile",
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
