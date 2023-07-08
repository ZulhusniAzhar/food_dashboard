import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/home_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/profile/profile_screen.dart';
import 'package:food_dashboard/src/features/qrcode/screens/qr_code_screen.dart';
import 'package:food_dashboard/src/features/qrcode/screens/scanner/qr_result_screen.dart';
import 'package:food_dashboard/src/features/rolechange/screen/list_role_form_screen.dart';

import '../features/payment/screen/buyer/payment_made_list_screen.dart';
import '../features/profilendashboard/screens/dashboard/analytical_dashboard.dart';
import '../features/report_ticket/screen/admin_list_report_screen.dart';
import '../features/report_ticket/screen/widget/cubalistbiasa.dart';

var pages = [
  const HomeScreen(),
  // QrResultScreen(
  //     widgetpostID: "tE99wlwvXfnuiPEDWLmP",
  //     widgetsellerID: "7aZeiidgMIXY0grledXvLqyS1Gw2"),
  PaymentListSellerScreen(),
  // MyTabbedScreen(),
  const QRCodeScreen(),
  ProfileScreen(),
];
var pagesAdmin = [
  const AnalyticalDashboardScreen(),
  const RoleFormListScreen(),
  // ReportAdminTicketListScreen(),
  ReportAdminTicketListScreen2(),
  ProfileScreen(),
];
