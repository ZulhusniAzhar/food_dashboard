import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String userID;
  String paymentID;
  final String sellerID;
  final String method;
  final DateTime datePayment;
  final double paymentTotal;
  final int itemTotal;
  final int statusPayment;
  final DateTime createdAt;
  final DateTime? deletedAt;

  PaymentModel({
    required this.userID,
    required this.sellerID,
    required this.paymentID,
    required this.method,
    required this.datePayment,
    required this.paymentTotal,
    required this.itemTotal,
    required this.statusPayment,
    required this.createdAt,
    required this.deletedAt,
  });
  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      userID: map['userID'],
      paymentID: map['paymentID'],
      sellerID: map['sellerID'],
      method: map['method'],
      datePayment: map['datePayment'],
      paymentTotal: map['paymentTotal'],
      statusPayment: map['statusPayment'],
      itemTotal: map['itemTotal'],
      createdAt: map['createdAt'].toDate(),
      deletedAt: map['deletedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "paymentID": paymentID,
      "sellerID": sellerID,
      "method": method,
      "datePayment": datePayment,
      "paymentTotal": paymentTotal,
      "statusPayment": statusPayment,
      "itemTotal": itemTotal,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }

  static PaymentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PaymentModel(
      userID: snapshot['userID'],
      paymentID: snapshot['paymentID'],
      sellerID: snapshot['sellerID'],
      method: snapshot['method'],
      datePayment: snapshot['datePayment'],
      paymentTotal: snapshot['paymentTotal'],
      statusPayment: snapshot['statusPayment'],
      itemTotal: snapshot['itemTotal'],
      createdAt: snapshot['createdAt'],
      deletedAt: snapshot['deletedAt'],
    );
  }
}
