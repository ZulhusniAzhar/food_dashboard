import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  final email = TextEditingController();
  final password = TextEditingController();
  // final userRepo = Get.put(UserRepository());

  // void signIn(String email, String password) {
  //   AuthenticationRepository.instance
  //       .loginUserwithEmailandPassword(email, password);
  // }
}
