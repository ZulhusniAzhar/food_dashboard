import 'package:cloud_firestore/cloud_firestore.dart';

class RoleFormModel {
  final String rfID;
  final String? userID;
  final DateTime createdAt;
  final String status;
  //status
  // 0: Ongoing
  // 1:Completed
  // 2:AdminIntervention
  final List<String> itemsSelling;
  final String? descriptionRF;
  final String blockSelling;
  final String collegeSelling;
  final DateTime? deletedAt;

  RoleFormModel({
    required this.rfID,
    required this.userID,
    required this.createdAt,
    required this.status,
    required this.itemsSelling,
    required this.descriptionRF,
    required this.blockSelling,
    required this.collegeSelling,
    required this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "rfID": rfID,
      "userID": userID,
      "createdAt": createdAt,
      "status": status,
      "itemsSelling": itemsSelling,
      "descriptionRF": descriptionRF,
      "blockSelling": blockSelling,
      "collegeSelling": collegeSelling,
      "deletedAt": deletedAt,
    };
  }

  static RoleFormModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RoleFormModel(
      rfID: snapshot['rfID'],
      userID: snapshot['userID'],
      createdAt: snapshot['createdAt'],
      status: snapshot['status'],
      itemsSelling: snapshot['itemsSelling'],
      descriptionRF: snapshot['descriptionRF'],
      blockSelling: snapshot['blockSelling'],
      collegeSelling: snapshot['collegeSelling'],
      deletedAt: snapshot['deletedAt'],
    );
  }

  factory RoleFormModel.fromMap(Map<String, dynamic> map) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return RoleFormModel(
      rfID: map['rfID'],
      userID: map['userID'],
      createdAt: map['createdAt'],
      status: map['status'],
      itemsSelling: map['itemsSelling'],
      descriptionRF: map['descriptionRF'],
      blockSelling: map['blockSelling'],
      collegeSelling: map['collegeSelling'],
      deletedAt: map['deletedAt'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "rfID": rfID,
      "userID": userID,
      "createdAt": createdAt,
      "status": status,
      "itemsSelling": itemsSelling,
      "descriptionRF": descriptionRF,
      "blockSelling": blockSelling,
      "collegeSelling": collegeSelling,
      "deletedAt": deletedAt,
    };
  }
}
