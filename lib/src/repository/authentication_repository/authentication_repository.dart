import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/auth.dart';
import 'package:food_dashboard/src/features/authentication/screens/login/login_screen.dart';
import 'package:food_dashboard/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/controllers/profile_controller.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dashboard/src/features/authentication/models/user_model.dart'
    as model;
import 'package:image_picker/image_picker.dart';

import '../../features/authentication/models/user_model.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  late Rx<User?> _firebaseUser;
  var verificationId = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Users');
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  User get user => _firebaseUser.value!;
  final profileController = Get.put(ProfileController());
  RxString role = RxString('');
  final RxString chosenCollege = ''.obs;
  final RxString chosenGender = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    _firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //check user dah logout ke, kalau ya, bawa ke welcomescreen
    if (user == null) {
      Get.offAll(() => const WelcomeScreen());
    } else {
      Get.offAll(() => Dashboard(
            pageIdx: 0,
          ));
    }
  }

  // Future<void> phoneAuthentication(String phoneNo) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     verificationCompleted: (credential) async {
  //       await _auth.signInWithCredential(credential);
  //     },
  //     codeSent: (verificationId, resendToken) {
  //       this.verificationId.value = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {
  //       this.verificationId.value = verificationId;
  //     },
  //     verificationFailed: (e) {
  //       if (e.code == 'Invalid-phone-number') {
  //         Get.snackbar('Error', 'The number provided is not valid.');
  //       } else {
  //         Get.snackbar(
  //             'Error', 'Something went wrong. Please try again later.');
  //       }
  //       //lebih error code can go: firebase.google.com/docs/auth/admin/errors
  //     },
  //   );
  // }

  // Future<bool> verifyOTP(String otp) async {
  //   var credentials = await _auth.signInWithCredential(
  //       PhoneAuthProvider.credential(
  //           verificationId: this.verificationId.value, smsCode: otp));
  //   return credentials.user != null ? true : false;
  // }

  // loginWithPhoneNo(String phoneNumber) async {
  //   try {
  //     await _auth.signInWithPhoneNumber(phoneNumber);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'invalid-phone-number') {
  //       Get.snackbar("Error", "Invalid Phone No");
  //     }
  //   } catch (_) {
  //     Get.snackbar("Error", "Something went wrong.");
  //   }
  // }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
    String fullName,
    String email,
    String matricNo,
    String gender,
    String phoneNo,
    String password,
    String block,
    String college,
    String role,
    // {File? image}
  ) async {
    try {
      print(gender);
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          matricNo.isNotEmpty &&
          phoneNo.isNotEmpty &&
          password.isNotEmpty) {
        //save user into auth and firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // String? downloadUrl;
        // if (image != null) {
        //   downloadUrl = await _uploadToStorage(image);
        // } else {
        //   downloadUrl = "";
        // }
        // phoneNo = "+60$phoneNo";
        model.UserModel user = model.UserModel(
          uid: cred.user!.uid,
          profilePhoto: "",
          fullName: fullName,
          matricNo: matricNo,
          gender: gender,
          email: email,
          phoneNo: phoneNo,
          password: password,
          block: block,
          college: college,
          role: role,
        );
        firestore.collection('Users').doc(cred.user!.uid).set(user.toJson());
      } else {
        Get.snackbar("Error", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        storeUserRole(getCurrentUserId());
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error LoggingIn',
        e.toString(),
      );
    }
  }

  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
    }
  }

  Future<UserModel?> getUserDetail(String id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    DocumentSnapshot userData = await collection.doc(id).get();
    return UserModel.fromSnap(userData);
  }

  Future<void> storeUserRole(String id) async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData = await collection.doc(id).get();
    Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
    role.value = data['role'];
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.to(LoginScreen());
      Get.snackbar(
        'Success',
        'Successfully sent email',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error ',
        e.toString(),
      );
    }
  }

  Future<void> logout() async => await firebaseAuth.signOut();
}
