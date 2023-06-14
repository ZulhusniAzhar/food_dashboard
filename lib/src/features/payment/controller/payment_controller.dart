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

  Future<void> fetchPaymentsBuyer(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await paymentCollection.where('userID', isEqualTo: userId).get();

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
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

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

  List<String> getUniqueMonthsBuyer() {
    List<String> uniqueMonths = [];
    // print(paymentsasBuyer);
    paymentsasBuyer.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.datePayment);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<String> getUniqueMonthsSeller() {
    List<String> uniqueMonths = [];
    // print(paymentsasSeller);

    paymentsasSeller.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.datePayment);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<PaymentModel> getPaymentsByMonthBuyer(String monthYear) {
    return paymentsasBuyer
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.datePayment) == monthYear)
        .toList();
  }

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
