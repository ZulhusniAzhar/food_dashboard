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
    };
  }

  static ItemModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ItemModel(
      uid: snapshot['uid'],
      itemID: snapshot['itemID'],
      itemPhoto: snapshot['itemPhoto'],
      itemName: snapshot['itemName'],
      price: snapshot['price'],
      ingredient: snapshot['ingredient'],
      sideDish: snapshot['sideDish'],
      category: snapshot['category'],
      // itemId: snapshot['itemId'],
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
    };
  }
}
