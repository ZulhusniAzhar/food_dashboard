import 'package:cloud_firestore/cloud_firestore.dart';

class ReportTicketModel {
  final String reporterID;
  String reportID;
  final String sellerID;
  final String postID;
  final String problemCat;
  final String comment;
  final int statusTicket;
  final DateTime createdAt;
  final DateTime? deletedAt;

  ReportTicketModel({
    required this.reporterID,
    required this.reportID,
    required this.sellerID,
    required this.postID,
    required this.problemCat,
    required this.comment,
    required this.statusTicket,
    required this.createdAt,
    required this.deletedAt,
  });
  factory ReportTicketModel.fromMap(Map<String, dynamic> map) {
    return ReportTicketModel(
      reporterID: map['reporterID'],
      reportID: map['reportID'],
      sellerID: map['sellerID'],
      postID: map['postID'],
      // problemCat: (map['datePayment'] as Timestamp).toDate(),
      problemCat: map['problemCat'],
      comment: map['comment'],
      statusTicket: map['statusTicket'],
      createdAt: map['createdAt'],
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reporterID": reporterID,
      "reportID": reportID,
      "sellerID": sellerID,
      "postID": postID,
      // problemCat: (datePayment as Timestamp).toDate(),
      "problemCat": problemCat,
      "comment": comment,
      "statusTicket": statusTicket,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }

  static ReportTicketModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    Timestamp createdAtTimestamp = snapshot['createdAt'];
    DateTime createdAt = createdAtTimestamp.toDate();

    return ReportTicketModel(
      reporterID: snapshot['reporterID'],
      reportID: snapshot['reportID'],
      sellerID: snapshot['sellerID'],
      postID: snapshot['postID'],
      problemCat: snapshot['problemCat'],
      comment: snapshot['comment'],
      statusTicket: snapshot['statusTicket'],
      createdAt: createdAt,
      deletedAt: snapshot['deletedAt'],
    );
  }
}
