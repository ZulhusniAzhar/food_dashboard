import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uid;
  final String postID;
  final String itemID;
  final String caption;
  final int stockItem;
  final String postPhoto;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String venueBlock;
  final String venueCollege;
  final DateTime createdAt;
  final DateTime? deletedAt;

  PostModel({
    required this.uid,
    required this.postID,
    required this.itemID,
    required this.caption,
    required this.stockItem,
    required this.postPhoto,
    required this.timeStart,
    required this.timeEnd,
    required this.venueBlock,
    required this.venueCollege,
    required this.createdAt,
    required this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "postID": postID,
      "itemID": itemID,
      "caption": caption,
      "stockItem": stockItem,
      "postPhoto": postPhoto,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "venueBlock": venueBlock,
      "venueCollege": venueCollege,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      uid: snapshot['uid'],
      postID: snapshot['postID'],
      itemID: snapshot['itemID'],
      caption: snapshot['caption'],
      stockItem: snapshot['stockItem'],
      postPhoto: snapshot['postPhoto'],
      timeStart: snapshot['timeStart'],
      timeEnd: snapshot['timeEnd'],
      venueBlock: snapshot['venueBlock'],
      venueCollege: snapshot['venueCollege'],
      createdAt: snapshot['createdAt'],
      deletedAt: snapshot['deletedAt'],
    );
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      uid: map['uid'],
      postID: map['postID'],
      itemID: map['itemID'],
      caption: map['caption'],
      stockItem: map['stockItem'],
      postPhoto: map['postPhoto'],
      timeStart: map['timeStart'],
      timeEnd: map['timeEnd'],
      venueBlock: map['venueBlock'],
      venueCollege: map['venueCollege'],
      createdAt: map['createdAt'],
      deletedAt: map['deletedAt'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "postID": postID,
      "itemID": itemID,
      "caption": caption,
      "stockItem": stockItem,
      "postPhoto": postPhoto,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "venueBlock": venueBlock,
      "venueCollege": venueCollege,
      "createdAt": createdAt,
      "deletedAt": deletedAt,
    };
  }
}
