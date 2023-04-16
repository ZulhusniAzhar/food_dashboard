import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/auth.dart';
import 'package:food_dashboard/src/features/authentication/controllers/login_controller.dart';
import 'package:get/get.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  return null;
                },
                controller: controller.email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  return null;
                },
                obscureText: true,
                controller: controller.password,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: OutlineInputBorder(),
                  // suffixIcon: IconButton(
                  //   onPressed: null,
                  //   icon: Icon(Icons.remove_red_eye_sharp),
                  // ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalBottomSheet(context);
                    },
                    child: const Text(tForgetPassword)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () => Get.to(() => Dashboard()),
                  onPressed: () {
                    authRepo.loginUser(controller.email.text.trim(),
                        controller.password.text.trim());
                    // if (_formKey.currentState!.validate()) {
                    //   LoginController.instance.signIn(
                    //       controller.email.text.trim(),
                    //       controller.password.text.trim());
                    // }
                  },
                  child: Text(tLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ));
  }
}
