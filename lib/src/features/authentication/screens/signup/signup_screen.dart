// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/constants/text_strings.dart';
import 'package:food_dashboard/src/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/form/form_header_widget.dart';
import 'widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: FormHeaderWidget(
                    image: tWelcomeImage1,
                    title: tSignUpTitle,
                    subTitle: tSignUpSubTitle,
                  ),
                ),
                const SignUpFormWidget(),
                Column(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: tAlreadyHaveAccount,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const TextSpan(text: tLogin),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
