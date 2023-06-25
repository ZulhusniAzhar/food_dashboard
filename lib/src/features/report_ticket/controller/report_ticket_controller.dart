import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/post/model/post_model.dart';
import 'package:food_dashboard/src/features/report_ticket/model/reportticket_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../authentication/models/user_model.dart';
import '../../item/model/item_model.dart';
import '../../profilendashboard/screens/dashboard/dashboard.dart';
import '../../rolechange/screen/list_role_form_screen.dart';
import '../screen/report_list_screen.dart';

class ReportTicketController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference reportticketCollection =
      FirebaseFirestore.instance.collection('reportticket');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');
  RxList<ReportTicketModel> reportforBuyer = RxList<ReportTicketModel>();
  RxList<ReportTicketModel> reportforSeller = RxList<ReportTicketModel>();
  RxList<ReportTicketModel> reportforAdminIntervention =
      RxList<ReportTicketModel>();
  RxList<ReportTicketModel> reportforOngoing = RxList<ReportTicketModel>();

  RxString role = RxString('');

  final problemCat = TextEditingController();
  final comment = TextEditingController();
  final RxString chosenCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicketReportBuyer(getCurrentUserId());
    fetchTicketReportSeller(getCurrentUserId());
    fetchTicketReportAdminIntervention();
    fetchTicketReportOngoing();

    // print(reportforBuyer);
  }

  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
    }
  }

  Future<void> fetchTicketReportAdminIntervention() async {
    try {
      QuerySnapshot querySnapshot = await reportticketCollection
          .where('statusTicket', isEqualTo: 2)
          .get();

      reportforAdminIntervention.value = querySnapshot.docs.map((doc) {
        Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
        Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

        DateTime? createdAtDT = createdAtTS?.toDate();
        DateTime? deletedAtDT = deletedAtTS?.toDate();

        return ReportTicketModel(
          reporterID: doc['reporterID'],
          reportID: doc['reportID'],
          sellerID: doc['sellerID'],
          postID: doc['postID'],
          problemCat: doc['problemCat'],
          comment: doc['comment'],
          statusTicket: doc['statusTicket'],
          createdAt: createdAtDT ?? DateTime.now(),
          deletedAt: deletedAtDT,
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

  Future<void> fetchTicketReportOngoing() async {
    try {
      QuerySnapshot querySnapshot = await reportticketCollection
          .where('statusTicket', isEqualTo: 0)
          .get();

      reportforOngoing.value = querySnapshot.docs.map((doc) {
        Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
        Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

        DateTime? createdAtDT = createdAtTS?.toDate();
        DateTime? deletedAtDT = deletedAtTS?.toDate();

        return ReportTicketModel(
          reporterID: doc['reporterID'],
          reportID: doc['reportID'],
          sellerID: doc['sellerID'],
          postID: doc['postID'],
          problemCat: doc['problemCat'],
          comment: doc['comment'],
          statusTicket: doc['statusTicket'],
          createdAt: createdAtDT ?? DateTime.now(),
          deletedAt: deletedAtDT,
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

  Future<void> fetchTicketReportBuyer(String userId) async {
    try {
      QuerySnapshot querySnapshot = await reportticketCollection
          .where('reporterID', isEqualTo: userId)
          .get();

      reportforBuyer.value = querySnapshot.docs.map((doc) {
        Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
        Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

        DateTime? createdAtDT = createdAtTS?.toDate();
        DateTime? deletedAtDT = deletedAtTS?.toDate();

        return ReportTicketModel(
          reporterID: doc['reporterID'],
          reportID: doc['reportID'],
          sellerID: doc['sellerID'],
          postID: doc['postID'],
          problemCat: doc['problemCat'],
          comment: doc['comment'],
          statusTicket: doc['statusTicket'],
          createdAt: createdAtDT ?? DateTime.now(),
          deletedAt: deletedAtDT,
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

  Future<void> fetchTicketReportSeller(String userId) async {
    try {
      QuerySnapshot querySnapshot = await reportticketCollection
          .where('sellerID', isEqualTo: userId)
          .get();

      reportforSeller.value = querySnapshot.docs.map((doc) {
        Timestamp? createdAtTS = doc['createdAt'] as Timestamp?;
        Timestamp? deletedAtTS = doc['deletedAt'] as Timestamp?;

        DateTime? createdAtDT = createdAtTS?.toDate();
        DateTime? deletedAtDT = deletedAtTS?.toDate();

        return ReportTicketModel(
          reporterID: doc['reporterID'],
          reportID: doc['reportID'],
          sellerID: doc['sellerID'],
          postID: doc['postID'],
          problemCat: doc['problemCat'],
          comment: doc['comment'],
          statusTicket: doc['statusTicket'],
          createdAt: createdAtDT ?? DateTime.now(),
          deletedAt: deletedAtDT,
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
    reportforBuyer.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.createdAt);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<String> getUniqueMonthsSeller() {
    List<String> uniqueMonths = [];

    reportforSeller.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.createdAt);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<String> getUniqueMonthsAdmin() {
    List<String> uniqueMonths = [];
    // print(paymentsasSeller);

    reportforAdminIntervention.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.createdAt);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<String> getUniqueMonthsOngoing() {
    List<String> uniqueMonths = [];
    // print(paymentsasSeller);

    reportforOngoing.forEach((payment) {
      String monthYear = DateFormat('MMM yyyy').format(payment.createdAt);
      if (!uniqueMonths.contains(monthYear)) {
        uniqueMonths.add(monthYear);
      }
    });

    return uniqueMonths;
  }

  List<ReportTicketModel> getReportsByMonthBuyer(String monthYear) {
    return reportforBuyer
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.createdAt) == monthYear)
        .toList();
  }

  List<ReportTicketModel> getReportsByMonthSeller(String monthYear) {
    return reportforSeller
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.createdAt) == monthYear)
        .toList();
  }

  List<ReportTicketModel> getReportsByMonthAdminIntervention(String monthYear) {
    return reportforAdminIntervention
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.createdAt) == monthYear)
        .toList();
  }

  List<ReportTicketModel> getReportsByMonthOngoing(String monthYear) {
    return reportforOngoing
        .where((payment) =>
            DateFormat('MMM yyyy').format(payment.createdAt) == monthYear)
        .toList();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, hh:mm a').format(dateTime);
  }

  Future<void> storeUserRole(String id) async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData = await userCollection.doc(id).get();
    Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
    role.value = data['role'];
  }

  Future<void> addTicket(ReportTicketModel reportticket) async {
    try {
      final jsonItem = reportticket.toJson();
      final docRef = await _firestore.collection('reportticket').add(jsonItem);
      final docId = docRef.id;
      await _firestore.collection('reportticket').doc(docId).update({
        'reportID': docId,
      });
      Get.until((route) => route.isFirst);
      Get.to(() => Dashboard(
            pageIdx: 3,
          ));
      Get.snackbar(
        'Success',
        'Successfully created report ticket',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "The report fails because $e");
    }
  }

  Future<UserModel?> getUserDetail(String id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    DocumentSnapshot userData = await userCollection.doc(id).get();
    return UserModel.fromSnap(userData);
  }

  Future<ReportTicketModel?> getReportTicketDetail(String id) async {
    DocumentSnapshot ticketData = await reportticketCollection.doc(id).get();
    return ReportTicketModel.fromSnap(ticketData);
  }

  Future<UserModel?> getSellerDetail(String id) async {
    DocumentSnapshot sellerData = await userCollection.doc(id).get();
    return UserModel.fromSnap(sellerData);
  }

  Future<PostModel?> getPostDetail(String id) async {
    DocumentSnapshot postData = await postCollection.doc(id).get();
    return PostModel.fromSnap(postData);
  }

  Future<ItemModel?> getItemDetail(String id) async {
    DocumentSnapshot itemData = await itemCollection.doc(id).get();
    return ItemModel.fromSnap(itemData);
  }

  Future<void> changeStatusTicket(String documentId, int status) async {
    final ticketRef = reportticketCollection.doc(documentId);
    DateTime now = DateTime.now();

    try {
      await ticketRef.update({'statusTicket': status});
      // await ticketRef.update({'deletedAt': FieldValue.serverTimestamp()});

      Get.until((route) => route.isFirst);
      Get.to(() => ReportTicketListScreen());
      Get.back();
      Get.snackbar(
        'Success',
        'Successfully updated status of Ticket Issue',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
