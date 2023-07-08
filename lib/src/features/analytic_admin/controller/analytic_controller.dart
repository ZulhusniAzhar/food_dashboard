import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_dashboard/src/features/analytic_admin/model/chart_data.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../constants/colors.dart';
import '../../item/model/item_model.dart';

class AnalyticDashboardController extends GetxController {
  static AnalyticDashboardController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChartModel chartModel = ChartModel();
  RxList<BarChartGroupData> barChartGroupDatass = <BarChartGroupData>[].obs;
  List<List<Map<String, dynamic>>> categorizedLists = [];

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

  RxList<ItemModel> foodItems = <ItemModel>[].obs;
  RxList<ItemModel> drinkItems = <ItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    categorizePosts();
  }

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

  Stream<List<Map<String, dynamic>>> getAllItemsList() {
    final foodList = itemsCollection
        .where('category', isEqualTo: 'Food')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    final drinkList = itemsCollection
        .where('category', isEqualTo: 'Drink')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    return CombineLatestStream(
        [foodList, drinkList], (list) => list.reduce((a, b) => a + b));
  }

  Stream<List<Map<String, dynamic>>> getAllIssueTicketList() {
    final issueOngoingList = reportticketCollection
        .where('statusTicket', isEqualTo: 0)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    final issueAdminList = reportticketCollection
        .where('statusTicket', isEqualTo: 2)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    return CombineLatestStream([issueOngoingList, issueAdminList],
        (list) => list.reduce((a, b) => a + b));
  }

  Stream<List<List<Map<String, dynamic>>>> categorizePosts() async* {
    print('Categorized Lists: $categorizedLists');
    final postList = postsCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });

    categorizedLists = List.generate(7, (_) => []);

    await for (List<Map<String, dynamic>> posts in postList) {
      for (Map<String, dynamic> post in posts) {
        DateTime timestamp = post['timeStart'].toDate();
        int dayOfWeek = timestamp.weekday - 1;
        categorizedLists[dayOfWeek].add(post);
      }
    }
    fetchCategorizedLists();
  }

  void fetchCategorizedLists() {
    for (int i = 0; i < categorizedLists.length; i++) {
      barChartGroupDatass.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              y: categorizedLists[i].length.toDouble(),
              width: 25,
              colors: [kLightBlue],
            ),
          ],
        ),
      );
    }
  }
}
