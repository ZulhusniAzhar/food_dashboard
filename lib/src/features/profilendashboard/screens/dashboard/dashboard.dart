import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/widget/appbar.dart';

import '../../../../constants/page.dart';

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
    // final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; //Dark Mode
    // final controller = Get.put(DashboardController());

    return Scaffold(
      appBar: DashboardAppBar(
        isDark: isDark,
      ),
      body: pages[widget.pageIdx],
      // body: SafeArea(
      //   child: IndexedStack(
      //     index: controller.tabIndex,
      //     children: [
      //       HomeScreenWidget(txtTheme: txtTheme),
      //       const BookmarkListScreen(),
      //       const QrCodeScreen(),
      //       const ProfileScreen(),
      //     ],
      //   ),
      // ),
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 30),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded, size: 30),
              label: "Bookmarks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_rounded, size: 30),
              label: "QRCode",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded, size: 30),
              label: "Profile",
            ),
          ]),
    );
  }
}
