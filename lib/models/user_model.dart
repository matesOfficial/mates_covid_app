import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  bool isLoggedIn;
  User firebaseData;
  String name, email, photoUrl, uid, phoneNumber;

  UserModel({this.name, this.uid, this.email, this.photoUrl, this.isLoggedIn});

  UserModel.fromFirebase({this.firebaseData}) {
    if (this.firebaseData != null) {
      name = firebaseData.displayName;
      email = firebaseData.email;
      uid = firebaseData.uid;
      photoUrl = firebaseData.photoURL;
      phoneNumber = firebaseData.phoneNumber;
      isLoggedIn = true;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class UserProfile {
  String name;
  String email;
  String uid;
  String phoneNumber;
  String gender;

  UserProfile({this.name, this.email, this.uid, this.phoneNumber, this.gender});

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) data['name'] = this.name;
    if (this.email != null) data['email'] = this.email;
    if (this.uid != null) data['uid'] = this.uid;
    if (this.phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (this.gender != null) data['gender'] = this.gender;
    return data;
  }
}
