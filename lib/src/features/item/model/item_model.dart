import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String? uid;
  final String itemID;
  final String itemName;
  final double price;
  final List<String> ingredient;
  final List<String> sideDish;
  final String itemPhoto;
  final String category;
  // final String itemId;
  final DateTime createdAt;
  final DateTime? deletedAt;

  ItemModel({
    required this.uid,
    required this.itemID,
    required this.itemName,
    required this.price,
    required this.ingredient,
    required this.sideDish,
    required this.itemPhoto,
    required this.category,
    // required this.itemId,
    required this.createdAt,
    required this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "itemID": itemID,
      "itemPhoto": itemPhoto,
      "itemName": itemName,
      "price": price,
      "ingredient": ingredient,
      "sideDish": sideDish,
      "category": category,
      // "itemId": itemId,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }

  factory ItemModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    Timestamp createdAtTimestamp = snapshot['createdAt'];
    DateTime createdAt = createdAtTimestamp.toDate();

    Timestamp? deletedAtTimestamp = snapshot['deletedAt'];
    DateTime? deletedAt =
        deletedAtTimestamp != null ? deletedAtTimestamp.toDate() : null;
    return ItemModel(
      uid: snapshot['uid'],
      itemID: snapshot['itemID'],
      itemPhoto: snapshot['itemPhoto'],
      itemName: snapshot['itemName'],
      price: snapshot['price'].toDouble(),
      ingredient: List<String>.from(snapshot['ingredient']),
      sideDish: List<String>.from(snapshot['sideDish']),
      category: snapshot['category'],
      createdAt: createdAt,
      deletedAt: deletedAt,
    );
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return ItemModel(
      uid: map['uid'],
      itemID: map['itemID'],
      itemPhoto: map['itemPhoto'],
      itemName: map['itemName'],
      price: map['price'],
      ingredient: map['ingredient'],
      sideDish: map['sideDish'],
      category: map['category'],
      createdAt: map['createdAt'],
      deletedAt: map['deletedAt'],
      // itemId: map['itemId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "itemID": itemID,
      "itemPhoto": itemPhoto,
      "itemName": itemName,
      "price": price,
      "ingredient": ingredient,
      "sideDish": sideDish,
      "category": category,
      // "itemId": itemId,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }
}
