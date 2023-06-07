import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/payment/model/payment_model.dart';
import 'package:food_dashboard/src/features/payment/screen/buyer/thanks_page.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payment');
  final paymentsasBuyer = <PaymentModel>[].obs;
  final paymentsasSeller = <PaymentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentsBuyer(getCurrentUserId());
    fetchPaymentsSeller(getCurrentUserId());
  }

  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
    }
  }

  Future<void> fetchPaymentsBuyer(String userId) async {
    try {
      // final querySnapshot = await _firestore
      //     .collection('payment')
      //     .where('userID', isEqualTo: userId)
      //     .get();

      QuerySnapshot querySnapshot =
          await paymentCollection.where('userID', isEqualTo: userId).get();

      paymentsasBuyer.value = querySnapshot.docs
          .map((doc) => PaymentModel(
                userID: doc['userID'],
                paymentID: doc['paymentID'],
                sellerID: doc['sellerID'],
                method: doc['method'],
                datePayment: doc['datePayment'],
                paymentTotal: doc['paymentTotal'],
                statusPayment: doc['statusPayment'],
                itemTotal: doc['itemTotal'],
                createdAt: doc['createdAt'],
                deletedAt: doc['deletedAt'],
              ))
          .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error fetching the list of settled payment',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchPaymentsSeller(String userId) async {
    try {
      // final querySnapshot = await _firestore
      //     .collection('payment')
      //     .where('sellerID', isEqualTo: userId)
      //     .get();

      QuerySnapshot querySnapshot =
          await paymentCollection.where('sellerID', isEqualTo: userId).get();

      paymentsasBuyer.value = querySnapshot.docs
          .map((doc) => PaymentModel(
                userID: doc['userID'],
                paymentID: doc['paymentID'],
                sellerID: doc['sellerID'],
                method: doc['method'],
                datePayment: doc['datePayment'],
                paymentTotal: doc['paymentTotal'],
                statusPayment: doc['statusPayment'],
                itemTotal: doc['itemTotal'],
                createdAt: doc['createdAt'],
                deletedAt: doc['deletedAt'],
              ))
          .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error fetching the list of settled payment',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addPayment(PaymentModel payments) async {
    try {
      final jsonItem = payments.toJson();
      // await _firestore.collection('payment').add(jsonItem);
      final docRef = await _firestore.collection('payment').add(jsonItem);
      final docId = docRef.id;

      // Update the payment with the document ID
      // payments.paymentID = docId;

      // Update the payment document with the document ID
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
}
