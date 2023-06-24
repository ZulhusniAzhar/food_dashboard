import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_dashboard/src/features/item/model/item_model.dart'
    as model;
import '../../../constants/auth.dart';
import '../model/item_model.dart';
import '../screens/item_list_screen.dart';

class ItemController extends GetxController {
  static ItemController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');
  Rx<File?> _pickedImage = Rx<File?>(null);
  File? get itemImage => _pickedImage.value;
  final RxString itemIDCurrent = ''.obs;

  late final DocumentReference documentReference = itemCollection.doc();
  var chooseImage = false.obs;
  var isLoading = true.obs;
  final RxString imagePath = ''.obs;
  final RxString categoryItem = ''.obs;
  var itemPhoto = ''.obs;

  final name = TextEditingController();
  final category = TextEditingController();
  final ingredient = TextEditingController();
  final sideDish = TextEditingController();
  final price = TextEditingController();

  String? getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  void pickImage(ImageSource src) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: src);
      if (pickedImage != null) {
        _pickedImage.value = File(pickedImage.path);

        imagePath.value = pickedImage.path;
        Get.snackbar(
          'Success',
          'Successfully added image for item',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigator.pop(context);
      }
      _pickedImage = Rx<File?>(File(pickedImage!.path));
      chooseImage.value = true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Fail adding image for item, ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void pickImageUpdate(ImageSource src) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: src);
      if (pickedImage != null) {
        _pickedImage.value = File(pickedImage.path);

        // Get.snackbar(
        //   'Success',
        //   'Successfully updated image for item',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        // // Navigator.pop(context);
      }
      _pickedImage = Rx<File?>(File(pickedImage!.path));
      updateItemImage(itemImage);
      print("itemID:${itemIDCurrent}");
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   'Fail updating image for item, ${e.toString()}',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  Future<void> updateItemImage(File? image) async {
    final itemCollection = FirebaseFirestore.instance.collection("items");
    final docRef = itemCollection.doc(itemIDCurrent.value);
    String downloadUrl = await _uploadToStorage(image!);
    try {
      await docRef.update({'itemPhoto': downloadUrl});
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

  Future<String> _uploadToStorage(File image) async {
    const String constWord = "item";
    DateTime now = DateTime.now();
    String unikId = "$constWord${now.microsecondsSinceEpoch}";
    Reference ref = firebaseStorage.ref().child('itemPics').child(unikId);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> createItem(
    String itemName,
    double? price,
    String category,
    List<String> ingredient,
    List<String> sideDishes,
    File? image,
  ) async {
    CollectionReference collectionReferencess =
        FirebaseFirestore.instance.collection('items');
    DocumentReference documentReferencess = collectionReferencess.doc();
    try {
      if (itemName.isNotEmpty &&
          category.isNotEmpty &&
          price != null &&
          image != null) {
        String downloadUrl = await _uploadToStorage(image);
        model.ItemModel item = model.ItemModel(
          uid: getCurrentUserId(),
          itemID: documentReferencess.id,
          itemPhoto: downloadUrl,
          itemName: itemName,
          price: price,
          ingredient: ingredient,
          sideDish: sideDishes,
          category: category,
          // itemId: getCurrentUserId(),
        );

        await documentReferencess.set(item.toJson());

        String documentId = documentReferencess.id;
        await documentReferencess.update({'itemID': documentId});
        Get.until((route) => route.isFirst);
        Get.to(() => const ItemListScreen());
        Get.snackbar(
          'Success',
          'Successfully created item',
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

  Future<DocumentSnapshot> getItemDetail(String docID) async {
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    return await itemCollection.doc(docID).get();

    // return userData.data();
  }

  static Future<void> updateItem(ItemModel item) async {
    final itemCollection = FirebaseFirestore.instance.collection("items");
    final docRef = itemCollection.doc(item.itemID);

    final newItem = ItemModel(
      uid: item.uid,
      itemID: item.itemID,
      itemName: item.itemName,
      price: item.price,
      ingredient: item.ingredient,
      sideDish: item.sideDish,
      itemPhoto: item.itemPhoto,
      category: item.category,
    ).toJson();

    try {
      await docRef.update(newItem);
      Get.until((route) => route.isFirst);
      Get.to(() => const ItemListScreen());
      Get.snackbar(
        'Success',
        'Successfully edited details for item',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      //
    }
  }

  Future<void> deleteItem(String docID) async {
    //kena del skali post yang berkaitan ngn item
    try {
      // final docRef = await itemCollection.doc(docID).delete();
      await itemCollection.doc(docID).delete();
      Get.until((route) => route.isFirst);
      Get.to(() => const ItemListScreen());
      Get.snackbar(
        'Success',
        'Successfully deleted item',
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
