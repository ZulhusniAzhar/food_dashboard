import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/home_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/profile/profile_screen.dart';
import 'package:food_dashboard/src/features/qrcode/screens/qr_code_screen.dart';
import 'package:food_dashboard/src/features/rolechange/screen/list_role_form_screen.dart';

import '../features/payment/screen/buyer/payment_made_list_screen.dart';
import '../features/profilendashboard/screens/dashboard/analytical_dashboard.dart';

var pages = [
  const HomeScreen(),
  // PaymentListSellerScreen(),
  MyTabbedScreen(),
  const QRCodeScreen(),
  ProfileScreen(),
];
var pagesAdmin = [
  const AnalyticalDashboardScreen(),
  const RoleFormListScreen(),
  ProfileScreen(),
];
