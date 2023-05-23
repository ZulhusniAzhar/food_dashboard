import 'package:food_dashboard/src/features/bookmarks/screens/bookmarks_list_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/home_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/profile/profile_screen.dart';
import 'package:food_dashboard/src/features/qrcode/screens/qr_code_screen.dart';
import 'package:food_dashboard/src/features/rolechange/screen/list_role_form_screen.dart';

import '../features/profilendashboard/screens/dashboard/analytical_dashboard.dart';

var pages = [
  const HomeScreen(),
  const BookmarkListScreen(),
  const QrCodeScreen(),
  ProfileScreen(),
];
var pagesAdmin = [
  const AnalyticalDashboardScreen(),
  const RoleFormListScreen(),
  ProfileScreen(),
];
