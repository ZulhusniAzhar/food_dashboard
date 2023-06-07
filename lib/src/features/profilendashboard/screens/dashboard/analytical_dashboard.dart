import 'package:flutter/material.dart';

import '../../../analytic_admin/screen/dashboard_analytics.dart';

class AnalyticalDashboardScreen extends StatelessWidget {
  const AnalyticalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: DashboardAnalytics());
  }
}
