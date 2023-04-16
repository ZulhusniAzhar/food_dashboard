// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 5.0,
        ),
        const SizedBox(
          height: tFormHeight,
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Get.to(
                () => const SignUpScreen(),
              );
            },
            child: Text.rich(
              TextSpan(
                text: tDontHaveAccount,
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(text: tSignUp, style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
