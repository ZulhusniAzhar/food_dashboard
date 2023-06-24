import 'package:flutter/material.dart';
import 'package:food_dashboard/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final matricNo = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController(text: "+06");
  final gender = TextEditingController();
  final block = TextEditingController();
  final college = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // void registerUser(String email, String password) {
  //   AuthenticationRepository.instance
  //       .createUserwithEmailandPassword(email, password);
  // }

  // Future<void> createUser(UserModel user) async {
  //   await userRepo.createUser(user);
  //   registerUser(user.email, user.password);
  //   // phoneAuthentication(user.phoneNo);

  //   // Get.to(() => const OTPScreen());
  // }

  // void phoneAuthentication(String phoneNo) {
  //   AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  // }
}
