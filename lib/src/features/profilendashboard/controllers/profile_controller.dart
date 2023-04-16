import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dashboard/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/auth.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Users');

  Future<UserModel?> getUserDetail() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    // DocumentSnapshot userData = await _usersCollection.doc(user.uid).get();
    DocumentSnapshot userData = await collection.doc(user.uid).get();
    // return userData.data();
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

  //tak pakai------------------------------------------------------------------------
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;
  Future<void> updateUserData(Map<String, dynamic> userData) async {
    UserModel? user = FirebaseAuth.instance.currentUser as UserModel?;
    DocumentReference userDocRef = _db.collection('Users').doc(user?.uid);
    await userDocRef.update(userData);
  }

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authRepo.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authRepo.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authRepo.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authRepo.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authRepo.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authRepo.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
