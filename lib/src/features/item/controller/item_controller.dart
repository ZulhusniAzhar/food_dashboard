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
import '../screens/item_list_screen.dart';

class ItemController extends GetxController {
  static ItemController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('items');
  late Rx<File?> _pickedImage;
  File? get itemImage => _pickedImage.value;
  var chooseImage = false.obs;
  late FirebaseFirestore _db;

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
    final pickedImage = await ImagePicker().pickImage(source: src);
    if (pickedImage != null) {
      Get.snackbar(
        'Success',
        'Successfully added image for item',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Navigator.pop(context);
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
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

  // void createItem(
  //   String itemName,
  //   double? price,
  //   String category,
  //   List<String> ingredient,
  //   List<String> sideDishes,
  //   File? image,
  // ) async {
  //   try {
  //     if (itemName.isNotEmpty &&
  //         category.isNotEmpty &&
  //         price != null &&
  //         image != null) {
  //       String downloadUrl = await _uploadToStorage(image);
  //       model.ItemModel item = model.ItemModel(
  //         uid: getCurrentUserId(),
  //         itemPhoto: downloadUrl,
  //         itemName: itemName,
  //         price: price,
  //         ingredient: ingredient,
  //         sideDish: sideDishes,
  //         // itemId: getCurrentUserId(),
  //       );
  //       firestore.collection('items').doc().set(item.toJson());
  //       Get.until((route) => route.isFirst);
  //       Get.to(() => ItemListScreen());
  //       Get.snackbar(
  //         'Success',
  //         'Successfully created item',
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       Get.snackbar("Error", "Please enter all the fields");
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //     );
  //   }
  // }

  void createItem(
    String itemName,
    double? price,
    String category,
    List<String> ingredient,
    List<String> sideDishes,
    File? image,
  ) async {
    try {
      //precondition (assert)
      assert(itemName.isNotEmpty, 'Item name must not be empty');
      assert(category.isNotEmpty, 'Category must not be empty');
      assert(price != null, 'Price must not be null');
      assert(image != null, 'Image must not be null');

      final allFieldsEntered = itemName.isNotEmpty &&
          category.isNotEmpty &&
          price != null &&
          image != null;

      //invariant (make sure the item never exist before)
      final existingItem = await firestore
          .collection('items')
          .where('itemName', isEqualTo: itemName)
          .get();

      Invariant(existingItem.docs.isNotEmpty, 'Item already exists');

      final downloadUrl = await _uploadToStorage(image!);

      final item = model.ItemModel(
        uid: getCurrentUserId(),
        itemPhoto: downloadUrl,
        itemName: itemName,
        price: price!,
        ingredient: ingredient,
        sideDish: sideDishes,
        // itemId: getCurrentUserId(),
      );

      await firestore.collection('items').doc().set(item.toJson());

      //post condition (check wether the item already saved in database by checking the name of the item)
      final existingItemAfter = await firestore
          .collection('items')
          .where('itemName', isEqualTo: itemName)
          .get();
      assert(!existingItemAfter.docs.isNotEmpty,
          'Item does not saved into the database sucessfully');

      Get.until((route) => route.isFirst);
      Get.to(() => ItemListScreen());

      Get.snackbar(
        'Success',
        'Successfully created item',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  void Invariant(bool condition, String message) {
    if (!condition) {
      throw Exception(message);
    }
  }
}
