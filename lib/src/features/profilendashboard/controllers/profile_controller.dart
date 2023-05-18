import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/auth.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Users');
  late Rx<File?> _pickedImage;
  File? get profileImage => _pickedImage.value;
  var chooseImage = false.obs;
  Rx<String> currentRole = Rx<String>('');

  Future<String?> getUserRole() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    DocumentSnapshot userData = await collection.doc(user.uid).get();
    late String? role = userData.get('role');
    return role;
  }

  void setRole(String role) {
    currentRole.value = role;
  }

  Future<UserModel?> getUserDetail() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    DocumentSnapshot userData = await collection.doc(user.uid).get();
    // return userData.data();
    String role = userData.get('role');
    setRole(role);
    return UserModel.fromSnap(userData);
  }

  Future<String?> printCreationTime() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // String idToken = await user.getIdToken();
      DateTime creationTime = DateTime.fromMillisecondsSinceEpoch(
          user.metadata.creationTime!.millisecondsSinceEpoch);
      return DateFormat('dd MM yyyy').format(creationTime);
    }
  }

  static Future<void> updateUser(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final docRef = userCollection.doc(user.uid);

    final newUser = UserModel(
      uid: user.uid,
      fullName: user.fullName,
      matricNo: user.matricNo,
      gender: user.gender,
      email: user.email,
      phoneNo: user.phoneNo,
      block: user.block,
      college: user.college,
      password: user.password,
      profilePhoto: user.profilePhoto,
      role: user.role,
    ).toJson();

    try {
      await docRef.update(newUser);
    } catch (e) {
      //
    }
  }

  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        final docRef = collection.doc(user.uid).delete();
        // Account deleted successfully
      } catch (e) {
        // An error occurred while deleting the account
      }
    }
  }

  String? getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  void pickImage(ImageSource src) async {
    final pickedImage = await ImagePicker().pickImage(source: src);
    if (pickedImage != null) {
      // Get.snackbar(
      //   'Success',
      //   'Successfully picked the image.',
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );

      // Navigator.pop(context);
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
    updateUserImage(profileImage);
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

  Future<void> updateUserImage(File? image) async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final docRef = userCollection.doc(getCurrentUserId());
    String downloadUrl = await _uploadToStorage(image!);
    try {
      await docRef.update({'profilePhoto': downloadUrl});
      Get.snackbar(
        'Success',
        'Successfully update the image.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Image update is not successfull',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    update();
  }
}
