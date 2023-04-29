import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/widget/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    return SafeArea(child: HomeScreenWidget(txtTheme: txtTheme));
  }
}
