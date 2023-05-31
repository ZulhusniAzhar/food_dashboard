// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/rolechange/screen/fill_role_form_screen.dart';
import 'package:food_dashboard/src/features/rolechange/screen/widget/role_form_widget.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dashboard/src/features/rolechange/model/roleform_model.dart'
    as model;

import '../../authentication/models/user_model.dart';
import '../../profilendashboard/screens/dashboard/dashboard.dart';
import '../screen/list_role_form_screen.dart';

class RoleFormController extends GetxController {
  static RoleFormController get instance => Get.find();

  //textfield
  final itemSelling = TextEditingController();
  final descriptionRF = TextEditingController();
  final blockSelling = TextEditingController();
  final collegeSelling = TextEditingController();
  final statusforReject = TextEditingController();

  //variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference roleFormCollection =
      FirebaseFirestore.instance.collection('roleform');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  Rx<String> currentStatus = Rx<String>('');
  late RxInt documentExistence = 0.obs;
  int get docExistent => documentExistence.value;
  String rfIDHolder = '';
  // @override
  // void onReady() {
  //   super.onReady();
  //   checkDocumentExists();
  // }

  String? getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> deletePreviousRoleForm() async {
    String documentId = '';
    QuerySnapshot querySnapshot = await roleFormCollection
        .where('userID', isEqualTo: getCurrentUserId())
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (QueryDocumentSnapshot document in documents) {
      documentId = document.id;
    }
    try {
      final docRef = await roleFormCollection.doc(documentId).delete();
      Get.until((route) => route.isFirst);
      Get.to(() => const FillRoleForm());
      Get.snackbar(
        'Success',
        'Successfully removed previous request',
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

  void createRoleForm(
    DateTime createdAt,
    String status,
    List<String> itemsSelling,
    String? descriptionRF,
    String blockSelling,
    String collegeSelling,
  ) async {
    CollectionReference collectionReferencess =
        FirebaseFirestore.instance.collection('roleform');
    DocumentReference documentReferencess = collectionReferencess.doc();
    try {
      if (status.isNotEmpty &&
          collegeSelling.isNotEmpty &&
          blockSelling.isNotEmpty &&
          itemsSelling.isNotEmpty) {
        model.RoleFormModel post = model.RoleFormModel(
          rfID: documentReferencess.id,
          userID: getCurrentUserId(),
          createdAt: createdAt,
          status: status,
          itemsSelling: itemsSelling,
          descriptionRF: descriptionRF,
          blockSelling: blockSelling,
          collegeSelling: collegeSelling,
          deletedAt: null,
        );
        await documentReferencess.set(post.toJson());

        String documentId = documentReferencess.id;
        await documentReferencess.update({'rfID': documentId});
        Get.until((route) => route.isFirst);
        Get.to(() => Dashboard(pageIdx: 3));
        Get.snackbar(
          'Success',
          'Successfully submitted the form for role change',
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

  // Future<DocumentSnapshot> getRoleFormDetail() async {
  //   // return await roleFormCollection.doc(docID).get();
  //   DocumentSnapshot roleFormData = await getDocumentRoleForm();
  //   return roleFormData;
  // }

  Future<DocumentSnapshot> getDocumentRoleFormDetail() async {
    String documentId = '';
    QuerySnapshot querySnapshot = await roleFormCollection
        .where('userID', isEqualTo: getCurrentUserId())
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (QueryDocumentSnapshot document in documents) {
      documentId = document.id;
    }
    return await roleFormCollection.doc(documentId).get();
  }

  Future<void> checkDocumentExists() async {
    String? id = getCurrentUserId();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('roleform') // Replace with your collection name
        .where('userID', isEqualTo: id)
        .limit(1)
        .get();
    documentExistence.value = snapshot.size;
    // await Future.delayed(Duration(seconds: 2));
    // return snapshot.size;
  }

  void setStatus(String? status) {
    currentStatus.value = status!;
  }

  Stream<List<Map<String, dynamic>>> getAllFormList() {
    return roleFormCollection
        // .orderBy('createdAt', descending: true)
        .where('deletedAt', isNull: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<UserModel?> getUserDetail(String id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    DocumentSnapshot userData = await userCollection.doc(id).get();
    return UserModel.fromSnap(userData);
  }

  void changeRoleFormStatusReject(String documentId, String description) {
    DocumentReference rfRef = roleFormCollection.doc(documentId);
    String newStatus = "Rejected because $description";
    DateTime now = DateTime.now();

    try {
      rfRef.update({'status': newStatus});
      rfRef.update({'deletedAt': now});
      // Get.to(() => RoleFormListScreen());
      Get.back();
      // update();
      Get.snackbar(
        'Success',
        'Successfully updated status',
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

  Future<void> changeRoleFormStatusAccept(String documentId) async {
    final rfRef = roleFormCollection.doc(documentId);

    DocumentSnapshot snapshot = await rfRef.get();
    var data = snapshot.data() as Map<String, dynamic>;
    var userID = data['userID'].toString();

    final userRef = userCollection.doc(userID);
    String newRole = "Seller";

    String newStatus = "Accepted";
    DateTime now = DateTime.now();
    try {
      await userRef.update({'role': newRole});
      await rfRef.update({'status': newStatus});
      await rfRef.update({'deletedAt': now});
      // Get.until((route) => route.isFirst);
      Get.to(() => RoleFormListScreen());
      Get.back();
      // update();
      Get.snackbar(
        'Success',
        'Successfully updated status',
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
