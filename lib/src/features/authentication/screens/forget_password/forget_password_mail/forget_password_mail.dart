import 'package:flutter/material.dart';
import 'package:food_dashboard/src/common_widgets/form/form_header_widget.dart';
import 'package:food_dashboard/src/constants/image_strings.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/constants/text_strings.dart';
import 'package:food_dashboard/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:get/get.dart';

import '../../../../../repository/authentication_repository/authentication_repository.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authRepo =
        Get.put(AuthenticationRepository.instance);
    final mailText = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              const SizedBox(height: tDefaultSize * 4),
              const FormHeaderWidget(
                image: tForgetPassImage,
                title: tForgetPassword,
                subTitle: tResetViaEmailSubTitle,
                crossAxisAlignment: CrossAxisAlignment.center,
                heightBetween: 30.0,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: tFormHeight),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: mailText,
                    decoration: const InputDecoration(
                        label: Text(tEmail),
                        hintText: tEmail,
                        prefixIcon: Icon(Icons.mail_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.to(() => const OTPScreen());
                        authRepo.resetPassword(mailText.text.trim());
                      },
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
