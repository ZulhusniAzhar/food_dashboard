import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/model/payment_model.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/thanks_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../authentication/models/user_model.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payment');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  // final paymentsasBuyer = <PaymentModel>[].obs;
  RxList<PaymentModel> paymentsasBuyer = RxList<PaymentModel>();
  // final paymentsasSeller = <PaymentModel>[].obs;
  RxString role = RxString('');
  RxList<PaymentModel> paymentsasSeller = RxList<PaymentModel>();

  @override
  void onInit() {
    super.onInit();
    fetchPaymentsBuyer(getCurrentUserId());
    fetchPaymentsSeller(getCurrentUserId());
    storeUserRole(getCurrentUserId());
  }

  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
    }
  }

//fetch list of payment made by the current user as the buyer
  Future<void> fetchPaymentsBuyer(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await paymentCollection.where('userID', isEqualTo: userId).get();
      if (querySnapshot != null) {
        paymentsasBuyer.value = querySnapshot.docs.map((doc) {
          Timestamp? datePaymentTS = doc['datePayment'] as Timestamp?;
          Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
          Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

          DateTime? datePaymentDT = datePaymentTS?.toDate();
          DateTime? createdAtDT = createdAtTS?.toDate();
          DateTime? deletedAtDT = deletedAtTS?.toDate();

          return PaymentModel(
            userID: doc['userID'],
            paymentID: doc['paymentID'],
            sellerID: doc['sellerID'],
            method: doc['method'],
            datePayment: datePaymentDT ?? DateTime.now(),
            paymentTotal: doc['paymentTotal'],
            statusPayment: doc['statusPayment'],
            itemTotal: doc['itemTotal'],
            createdAt: createdAtDT ?? DateTime.now(),
            deletedAt: doc['deletedAt'],
          );
        }).toList();
      } else {}
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

//fetch list of payment made by the current user as the seller
  Future<void> fetchPaymentsSeller(String sellerId) async {
    try {
      QuerySnapshot querySnapshot =
          await paymentCollection.where('sellerID', isEqualTo: sellerId).get();

      paymentsasSeller.value = querySnapshot.docs.map((doc) {
        Timestamp? datePaymentTS = doc['datePayment'] as Timestamp?;
        Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
        Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

        DateTime? datePaymentDT = datePaymentTS?.toDate();
        DateTime? createdAtDT = createdAtTS?.toDate();
        DateTime? deletedAtDT = deletedAtTS?.toDate();

        return PaymentModel(
          userID: doc['userID'],
          paymentID: doc['paymentID'],
          sellerID: doc['sellerID'],
          method: doc['method'],
          datePayment: datePaymentDT ?? DateTime.now(),
          paymentTotal: doc['paymentTotal'],
          statusPayment: doc['statusPayment'],
          itemTotal: doc['itemTotal'],
          createdAt: createdAtDT ?? DateTime.now(),
          deletedAt: doc['deletedAt'],
        );
      }).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

//fetch the month and year that the payment occured from fetchPaymentsBuyer()
  List<String> getUniqueMonthsBuyer() {
    List<String> uniqueMonths = [];

    paymentsasBuyer.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.datePayment);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

//fetch the month and year that the payment occured from fetchPaymentsSeller()
  List<String> getUniqueMonthsSeller() {
    List<String> uniqueMonths = [];

    paymentsasSeller.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.datePayment);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

//return the payment occured based on the month and year to be displayed under
  List<PaymentModel> getPaymentsByMonthBuyer(String monthYear) {
    return paymentsasBuyer
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.datePayment) == monthYear)
        .toList();
  }

//return the payment occured based on the month and year to be displayed under
  List<PaymentModel> getPaymentsByMonthSeller(String monthYear) {
    return paymentsasSeller
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.datePayment) == monthYear)
        .toList();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, hh:mm a').format(dateTime);
  }

  Future<UserModel?> getUserDetail(String id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    DocumentSnapshot userData = await userCollection.doc(id).get();
    return UserModel.fromSnap(userData);
  }

  Future<void> storeUserRole(String id) async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData = await userCollection.doc(id).get();
    Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
    role.value = data['role'];
  }

//create new payment
  Future<void> addPayment(PaymentModel payments, String postID) async {
    try {
      final jsonItem = payments.toJson();
      // await _firestore.collection('payment').add(jsonItem);
      final docRef = await _firestore.collection('payment').add(jsonItem);
      final docId = docRef.id;
      updateItemStock(postID, payments.itemTotal);

      await _firestore.collection('payment').doc(docId).update({
        'paymentID': docId,
      });
      Get.until((route) => route.isFirst);
      Get.to(() => const ThankYouPage());
      Get.snackbar(
        'Success',
        'Successfully settle payment',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "The payment fails");
    }
  }

//update the item stock after the payment succeeded
  Future<void> updateItemStock(String postID, int quantity) async {
    final ticketRef = postCollection.doc(postID);

// Retrieve current stock value from Firebase
    DocumentSnapshot postSnapshot = await ticketRef.get();
    Map<String, dynamic> data = postSnapshot.data() as Map<String, dynamic>;
    int currentStock = data['stockItem'];

//decrease as much as quantity
    int newStock = currentStock - quantity;

    await ticketRef.update({'stockItem': newStock});
  }
}
