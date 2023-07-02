import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dashboard/src/features/authentication/controllers/signup_controller.dart';
import 'package:food_dashboard/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import '../../../../../constants/college.dart';
import '../../../../../constants/gender.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final AuthenticationRepository authRepo =
        Get.put(AuthenticationRepository());
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
            // Center(
            //   child: Stack(
            //     children: [
            //       SizedBox(
            //         width: 120,
            //         height: 120,
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(100),
            //           child: const Image(image: AssetImage(tImageBlank)),
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 0,
            //         right: 0,
            //         child: Container(
            //           width: 35,
            //           height: 35,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(100),
            //               color: tPrimaryColor),
            //           child: IconButton(
            //             onPressed: () {
            //               authRepo.pickImage();
            //             },
            //             icon: const Icon(
            //               LineAwesomeIcons.camera,
            //               size: 20,
            //             ),
            //             color: Colors.black,
            //             // size: 20,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
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
            Text(
              "Gender",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),

            // ignore: sized_box_for_whitespace
            Container(
              width: 180, // Set the desired width
              height: 97,
              child: RadioGroup(
                scrollDirection: Axis.vertical,
                radioList: gender,
                selectedItem: 1,
                onChanged: (value) {
                  authRepo.chosenGender.value = value;
                },
              ),
            ),
            const SizedBox(height: tFormHeight + 4),
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
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
              ],
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
            Text(
              "College",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Container(
              width: 180, // Set the desired width
              height: 370, // Set the desired height
              child: RadioGroup(
                radioList: college,
                selectedItem: 1,
                onChanged: (value) {
                  authRepo.chosenCollege.value = value;
                },
              ),
            ),
            const SizedBox(height: tFormHeight + 5),
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
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        authRepo.chosenGender.value != null &&
                        authRepo.chosenCollege.value != null) {
                      authRepo.registerUser(
                        controller.fullName.text.trim(),
                        controller.email.text.trim(),
                        controller.matricNo.text.trim(),
                        authRepo.chosenGender.value,
                        controller.phoneNo.text.trim(),
                        controller.password.text.trim(),
                        controller.block.text.trim(),
                        authRepo.chosenCollege.value,
                        "General",
                        // image: authRepo.profilePhoto,
                      );
                    }
                  },
                  child: Text(tSignUp.toUpperCase()),
                )),
          ],
        ),
      ),
    );
  }
}
