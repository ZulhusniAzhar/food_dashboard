import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart'
    as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/screens/post_list_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/auth.dart';
import '../../item/model/item_model.dart';
import '../model/post_model.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

  //declare page related
  late Rx<File?> _pickedImage;
  RxBool chooseImage = false.obs;
  File? get postImage => _pickedImage.value;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  //declare db related
  RxList<PostModel> posts = <PostModel>[].obs;
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //textcontroller
  final caption = TextEditingController();
  final itemStock = TextEditingController();
  final timeStart = TextEditingController();
  final timeEnd = TextEditingController();
  final venueBlock = TextEditingController();
  final venueCollege = TextEditingController();

  // @override
  // void onInit() {
  //   // Call the initState method of GetxController
  //   super.onInit();
  //   // Do your own initialization tasks
  //   // For example, fetch some data from firebase
  //   createListDashboard();
  // }

  // void createListDashboard() async {
  //   QuerySnapshot querySnapshot = await postCollection.get();
  //   for (var doc in querySnapshot.docs) {
  //     PostModel post = PostModel.fromMap(doc);

  //     posts.add(post);
  //     print(posts);
  //   }
  // }
  Stream<List<Map<String, dynamic>>> getPostListDashboard() {
    return postCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  //functions
  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
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

  Stream<List<Map<String, dynamic>>> getPostListwithUid() {
    return postCollection
        .where('uid', isEqualTo: getCurrentUserId())
        // .orderBy('createdAt', descending: true)
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

  Future<String> _uploadToStorage(File image) async {
    const String constWord = "post";
    DateTime now = DateTime.now();
    String unikId = "$constWord${now.microsecondsSinceEpoch}";
    Reference ref = firebaseStorage.ref().child('postPics').child(unikId);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void createPost(
    String itemID,
    String caption,
    int stockItem,
    // Timestamp timeStart,
    // Timestamp timeEnd,
    String venueBlock,
    String venueCollege,
    DateTime createdAt,
    File? postPhoto,
  ) async {
    CollectionReference collectionReferencess =
        FirebaseFirestore.instance.collection('posts');
    DocumentReference documentReferencess = collectionReferencess.doc();
    try {
      if (itemID.isNotEmpty &&
          caption.isNotEmpty &&
          venueBlock.isNotEmpty &&
          venueCollege.isNotEmpty &&
          stockItem > 0 &&
          postPhoto != null) {
        String downloadUrl = await _uploadToStorage(postPhoto);
        model.PostModel post = model.PostModel(
          uid: getCurrentUserId(),
          postID: documentReferencess.id,
          itemID: itemID,
          caption: caption,
          stockItem: stockItem,
          timeStart: startDate,
          timeEnd: endDate,
          venueBlock: venueBlock,
          venueCollege: venueCollege,
          createdAt: createdAt,
          deletedAt: null,
          postPhoto: downloadUrl,
        );
        await documentReferencess.set(post.toJson());

        String documentId = documentReferencess.id;
        await documentReferencess.update({'itemID': documentId});
        Get.until((route) => route.isFirst);
        Get.to(() => const PostListScreen());
        Get.snackbar(
          'Success',
          'Successfully created post',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  Future<DocumentSnapshot> getPostDetail(String docID) async {
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    return await postCollection.doc(docID).get();
    // return userData.data();
  }

  Future<void> deletePost(String docID) async {
    try {
      final docRef = await postCollection.doc(docID).delete();
      Get.until((route) => route.isFirst);
      Get.to(() => const PostListScreen());
      Get.snackbar(
        'Success',
        'Successfully deleted post',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }
}
