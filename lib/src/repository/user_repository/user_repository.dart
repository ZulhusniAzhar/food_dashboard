import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // final _db = FirebaseFirestore.instance;

  //Store user in Firebase
  // Future<void> createUser(UserModel user) async {
  //   await _db
  //       .collection("Users")
  //       .add(user.toJson())
  //       // .whenComplete(
  //       //   () => Get.snackbar("Success", "Your account has been created.",
  //       //       snackPosition: SnackPosition.BOTTOM,
  //       //       backgroundColor: Colors.green.withOpacity(0.1),
  //       //       colorText: Colors.green),
  //       // )
  //       .catchError((error, stackTrace) {
  //     Get.snackbar("Error", "Something went wrong. Try again",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red);
  //     print(error.toString());
  //   });
  // }

  // //Fetch one specific user in Firebase
  // Future<UserModel> getUserDetails(String email) async {
  //   final snapshot =
  //       await _db.collection("Users").where("Email", isEqualTo: email).get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  //   //ni untuk dapatkan single record
  //   return userData;
  // }

  // //Fetch all user in Firebase
  // Future<List<UserModel>> allUser() async {
  //   final snapshot = await _db.collection("Users").get();
  //   final userData = snapshot.docs
  //       .map((e) => UserModel.fromSnapshot(e))
  //       .toList(); //ni untuk dapatkan multiple record
  //   return userData;
  // }

  // Future<void> updateUserRecord(UserModel user) async {
  //   await _db.collection("Users").doc(user.id).update(user.toJson());
  // }
}
