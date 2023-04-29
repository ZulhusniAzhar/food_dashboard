import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../item/model/item_model.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

  //declare page related
  late Rx<File?> _pickedImage;
  RxBool chooseImage = false.obs;

  //declare db related
  RxList<ItemModel> items = <ItemModel>[].obs;
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //textcontroller
  final caption = TextEditingController();
  final timeStart = TextEditingController();
  final timeEnd = TextEditingController();
  final venueBlock = TextEditingController();
  final venueCollege = TextEditingController();

  //functions
  String? getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> getItemsListwithUid() {
    return itemCollection
        .where('uid', isEqualTo: getCurrentUserId())
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  void pickImage(ImageSource src) async {
    final pickedImage = await ImagePicker().pickImage(source: src);
    if (pickedImage != null) {
      Get.snackbar(
        'Success',
        'Successfully added image for item',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  void addPost(Object item) {
    Object name = item;
    print(name);
  }
}
