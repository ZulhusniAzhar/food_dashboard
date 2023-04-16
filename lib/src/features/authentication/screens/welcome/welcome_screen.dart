import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/constants/text_strings.dart';
import 'package:food_dashboard/src/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';

import '../signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage(tWelcomeImage1),
              height: height * 0.5,
            ),
            Column(
              children: [
                const Text(
                  tWelcomeTitle,
                  // style: Theme.of(context).textTheme.titleLarge,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    // Get.off(NextPage());
                    child: Text(tLogin.toUpperCase()),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    child: Text(tSignUp.toUpperCase()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
