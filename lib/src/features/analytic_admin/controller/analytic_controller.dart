import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class AnalyticDashboardController extends GetxController {
  static AnalyticDashboardController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payment');
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference reportticketCollection =
      FirebaseFirestore.instance.collection('reportticket');
  final CollectionReference roleFormCollection =
      FirebaseFirestore.instance.collection('roleform');

  // Function to get the number of users for each role
  Stream<List<Map<String, dynamic>>> getAllRoleList() {
    final sellerList = userCollection
        .where('role', isEqualTo: "Seller")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    final studentList = userCollection
        .where('role', isEqualTo: "General")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    final administratorList = userCollection
        .where('role', isEqualTo: "Admin")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    return CombineLatestStream([sellerList, studentList, administratorList],
        (list) => list.reduce((a, b) => a + b));
  }
}
