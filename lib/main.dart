import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_dashboard/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:food_dashboard/src/repository/authentication_repository/authentication_repository.dart';
import 'package:food_dashboard/src/utils/theme/theme.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            themeMode: ThemeMode.system,
            defaultTransition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 500),
            home: const WelcomeScreen(),
          );
        });
  }
}
