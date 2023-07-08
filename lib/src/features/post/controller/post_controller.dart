import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_dashboard/src/features/item/model/item_model.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart'
    as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/screens/post_list_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/auth.dart';
import '../../profilendashboard/models/dashboard/categories_model.dart';
import '../model/post_model.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

  //declare page related
  late Rx<File?> _pickedImage;
  late RxString sellerPhoneNumber;
  RxBool chooseImage = false.obs;
  File? get postImage => _pickedImage.value;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  final selectedCategory = DashboardCategoriesModel.list[0].title.obs;
  final RxString collegeChosen = ''.obs;
  final RxString formattedSaleEnd = '23:59'.obs;
  final RxString formattedSaleStart = '00:00'.obs;

  //declare db related
  RxList<PostModel> posts = <PostModel>[].obs;
  Rx<PostModel?> postModelforDetail = Rx<PostModel?>(null);
  Rx<ItemModel?> itemModelforDetail = Rx<ItemModel?>(null);
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
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

  void changeCategory(String title) {
    selectedCategory.value = title;
  }

  void fetchData(String postID) async {
    try {
      final DocumentReference postReference =
          FirebaseFirestore.instance.collection('posts').doc('postID');
      postReference.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          final String itemID = data['itemID'].toString();
          postModelforDetail.value = PostModel.fromMap(data);

          final DocumentReference itemReference =
              FirebaseFirestore.instance.collection('items').doc(itemID);
          itemReference.get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              final Map<String, dynamic> data =
                  documentSnapshot.data() as Map<String, dynamic>;
              itemModelforDetail.value = ItemModel.fromMap(data);
            }
          });
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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

  Stream<List<Map<String, dynamic>>> getPostListDashboardwithCollege(
      String? venueCollege) {
    Query postQuery = postCollection.orderBy('createdAt', descending: true);

    if (venueCollege == 'ALL') {
      // Return all posts without filtering by venueCollege
      return postQuery.snapshots().map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } else {
      // Delete posts with timeEnd in the past
      deletePostsBeforeToday();

      // Return filtered posts by venueCollege
      return postCollection
          .where('venueCollege', isEqualTo: venueCollege)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    }
  }

  void deletePostsBeforeToday() async {
    DateTime today = DateTime.now();

    // Query posts with timeEnd in the past
    final QuerySnapshot snapshot =
        await postCollection.where('timeEnd', isLessThan: today).get();

    // Delete the posts
    for (final DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
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

  Future<DocumentSnapshot> getSellerPhoneNo(String userID) async {
    DocumentSnapshot firstSnapshot = await userCollection.doc(userID).get();

    return firstSnapshot;
  }

  Future<void> setSellerPhoneNo(String postID) async {
    final DocumentReference postReference =
        FirebaseFirestore.instance.collection('posts').doc('postID');
    postReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final String sellerID = data['userID'].toString();
        // print(attributeAsString);

        final DocumentReference itemReference =
            FirebaseFirestore.instance.collection('Users').doc(sellerID);
        itemReference.get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            final Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;
            final String sellerPhoneNo = data['phoneNo'].toString();
            sellerPhoneNumber.value = sellerPhoneNo;
          } else {
            sellerPhoneNumber.value = "";
          }
        });
      } else {
        sellerPhoneNumber.value = "";
      }
    });
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

  Stream<List<Map<String, dynamic>>> getPostListSeller(String sellerID) {
    return postCollection
        .where('uid', isEqualTo: sellerID)
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
    String saleStart,
    String saleEnd,
    // Timestamp timeStart,
    // Timestamp timeEnd,
    String venueBlock,
    String venueCollege,
    DateTime createdAt,
    // File? postPhoto,
  ) async {
    CollectionReference collectionReferencess =
        FirebaseFirestore.instance.collection('posts');
    DocumentReference documentReferencess = collectionReferencess.doc();
    try {
      if (itemID.isNotEmpty &&
              caption.isNotEmpty &&
              venueBlock.isNotEmpty &&
              venueCollege.isNotEmpty &&
              stockItem > 0
          // &&
          // postPhoto != null
          ) {
        // String downloadUrl = await _uploadToStorage(postPhoto);
        model.PostModel post = model.PostModel(
          uid: getCurrentUserId(),
          postID: documentReferencess.id,
          itemID: itemID,
          caption: caption,
          stockItem: stockItem,
          saleTimeStart: saleStart,
          saleTimeEnd: saleEnd,
          timeStart: startDate,
          timeEnd: endDate,
          venueBlock: venueBlock,
          venueCollege: venueCollege,
          createdAt: createdAt,
          deletedAt: null,
          // postPhoto: downloadUrl,
        );
        await documentReferencess.set(post.toJson());
        String documentId = documentReferencess.id;
        await documentReferencess.update({'postID': documentId});
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
        "Theres a problem",
      );
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      final postCollection = FirebaseFirestore.instance.collection("posts");
      final docRef = postCollection.doc(post.postID);

      final newPost = PostModel(
              uid: post.uid,
              postID: post.postID,
              itemID: post.itemID,
              caption: post.caption,
              stockItem: post.stockItem,
              saleTimeStart: post.saleTimeStart,
              saleTimeEnd: post.saleTimeEnd,
              timeStart: startDate,
              timeEnd: endDate,
              venueBlock: post.venueBlock,
              venueCollege: post.venueCollege,
              createdAt: post.createdAt,
              deletedAt: post.deletedAt)
          .toJson();

      await docRef.update(newPost);
      Get.until((route) => route.isFirst);
      Get.to(() => const PostListScreen());
      Get.snackbar(
        'Success',
        'Successfully edited details for post',
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

  Future<DocumentSnapshot> getPostDetail(String docID) async {
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    return await postCollection.doc(docID).get();
    // return userData.data();
  }

  Future<DocumentSnapshot> getPostNItemDetails(String docID) async {
    // Get the Document Snapshot for the first document
    DocumentSnapshot firstSnapshot = await postCollection.doc(docID).get();

    // Get the attribute value from the first document

    // String attributeValue =
    //     (firstSnapshot as Map<String, dynamic>).['itemID'].toString();

    // // Use the attribute value to get the second document
    // DocumentSnapshot secondSnapshot = await FirebaseFirestore.instance
    //     .collection('secondCollectionName')
    //     .doc(attributeValue)
    //     .get();

    // Return the Document Snapshots
    return firstSnapshot;
  }

  Future<DocumentSnapshot> getItemDetailsbyPost(String docID) async {
    // Get the Document Snapshot for the first document
    DocumentSnapshot firstSnapshot = await itemCollection.doc(docID).get();

    return firstSnapshot;
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

  Future<String?> itemImage(String postID) async {
    final DocumentReference postReference =
        FirebaseFirestore.instance.collection('posts').doc('postID');
    postReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final String itemID = data['itemID'].toString();
        // print(attributeAsString);

        final DocumentReference itemReference =
            FirebaseFirestore.instance.collection('items').doc(itemID);
        itemReference.get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            final Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;
            final String itemPhoto = data['itemPhoto'].toString();
            return itemPhoto;
          } else {
            // print('Document does not exist on the database');
            return ['No Data'];
          }
        });
      } else {
        // print('Document does not exist on the database');
        return ['No Data'];
      }
    });
  }
}
