import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/auth.dart';
import 'package:food_dashboard/src/features/authentication/controllers/signup_controller.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    bool _obsecureText = true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tImageBlank)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor),
                      child: IconButton(
                        onPressed: () {
                          authRepo.pickImage();
                        },
                        icon: const Icon(
                          LineAwesomeIcons.camera,
                          size: 20,
                        ),
                        color: Colors.black,
                        // size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.matricNo,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tMatricNo),
                  prefixIcon: Icon(Icons.numbers_rounded)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.gender,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("Gender (Male/Female)"),
                  prefixIcon: Icon(Icons.boy_rounded)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.email,
              validator: (String? value) => EmailValidator.validate(value!)
                  ? null
                  : "Please enter a valid email",
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.phoneNo,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tPhoneNo), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.password,
              obscureText: _obsecureText,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tPassword), prefixIcon: Icon(Icons.fingerprint)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.block,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("Block"), prefixIcon: Icon(Icons.house)),
            ),
            const SizedBox(height: tFormHeight),
            TextFormField(
              controller: controller.college,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Field is required.';
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("College"), prefixIcon: Icon(Icons.house)),
            ),
            const SizedBox(height: tFormHeight),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   //Email Password Authentication
                    //   // =>
                    //   // SignUpController.instance.registerUser(
                    //   //     controller.email.text.trim(),
                    //   //     controller.password.text.trim());

                    //   //Phone Number Authentication
                    //   // =>
                    //   // SignUpController.instance
                    //   //     .phoneAuthentication(controller.phoneNo.text.trim());
                    //   // Get.to(() => OTPScreen());

                    //   // final user = UserModel(
                    //   //   fullName: controller.fullName.text.trim(),
                    //   //   role: "General",
                    //   //   matricNo: controller.matricNo.text.trim(),
                    //   //   gender: controller.gender.text.trim(),
                    //   //   email: controller.email.text.trim(),
                    //   //   phoneNo: controller.phoneNo.text.trim(),
                    //   //   password: controller.password.text.trim(),
                    //   //   block: controller.block.text.trim(),
                    //   //   college: controller.college.text.trim(),
                    //   // );
                    //   // SignUpController.instance.createUser(user);
                    //   // Get.to(() => OTPScreen());
                    // }

                    authRepo.registerUser(
                      controller.fullName.text.trim(),
                      controller.email.text.trim(),
                      controller.matricNo.text.trim(),
                      controller.gender.text.trim(),
                      controller.phoneNo.text.trim(),
                      controller.password.text.trim(),
                      controller.block.text.trim(),
                      controller.college.text.trim(),
                      "General",
                      authRepo.profilePhoto,
                    );
                  },
                  child: Text(tSignUp.toUpperCase()),
                )),
          ],
        ),
      ),
    );
  }
}
