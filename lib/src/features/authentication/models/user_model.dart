import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String fullName;
  final String matricNo;
  final String gender;
  final String email;
  final String phoneNo;
  final String password;
  final String block;
  final String college;
  final String profilePhoto;
  final String role;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.matricNo,
    required this.gender,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.block,
    required this.college,
    required this.profilePhoto,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "profilePhoto": profilePhoto,
      "fullName": fullName,
      "matricNo": matricNo,
      "gender": gender,
      "email": email,
      "phoneNo": phoneNo,
      "password": password,
      "block": block,
      "college": college,
      "role": role,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto'],
        role: snapshot['role'],
        fullName: snapshot['fullName'],
        matricNo: snapshot['matricNo'],
        gender: snapshot['gender'],
        email: snapshot['email'],
        phoneNo: snapshot['phoneNo'],
        password: snapshot['password'],
        block: snapshot['block'],
        college: snapshot['college']);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: map['uid'],
        profilePhoto: map['profilePhoto'],
        role: map['role'],
        fullName: map['fullName'],
        matricNo: map['matricNo'],
        gender: map['gender'],
        email: map['email'],
        phoneNo: map['profilePhoto'],
        password: map['password'],
        block: map['block'],
        college: map['college']);
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "profilePhoto": profilePhoto,
      "fullName": fullName,
      "matricNo": matricNo,
      "gender": gender,
      "email": email,
      "phoneNo": phoneNo,
      "password": password,
      "block": block,
      "college": college,
      "role": role,
    };
  }
}
