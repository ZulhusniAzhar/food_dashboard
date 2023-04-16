import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/constants/text_strings.dart';
import 'package:food_dashboard/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:food_dashboard/src/utils/theme/widget_theme/text_theme.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashController.animate.value ? 0 : -30,
              left: splashController.animate.value ? 0 : -30,
              child: const Image(
                image: AssetImage(tSplashTopIcon),
                width: 180,
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 80,
              left: splashController.animate.value ? tDefaultSize : -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tAppName,
                      style: TTextTheme.lightTextTheme.titleSmall,
                    ),
                    Text(
                      tAppTagLine,
                      style: TTextTheme.lightTextTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              bottom: splashController.animate.value ? 70 : 0,
              left: splashController.animate.value ? -10 : -40,
              child: const Image(
                image: AssetImage(tSplashImage),
                width: 460,
                height: 500,
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splashController.animate.value ? 60 : -10,
              right: tDefaultSize,
              child: Container(
                width: tSplashContainerSize,
                height: tSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
