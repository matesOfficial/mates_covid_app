import 'package:cloud_firestore/cloud_firestore.dart';
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
  String uid;
  String name;
  String photoUrl;
  String email;
  String gender;
  String phoneNumber;
  String bloodGroup;
  String city;
  int pinCode;
  String collegeName;
  Timestamp dateOfLastBloodDonation;
  bool isVerifiedPlasmaDonor;

  UserProfile(
      {this.uid,
        this.name,
        this.photoUrl,
        this.email,
        this.gender,
        this.phoneNumber,
        this.bloodGroup,
        this.city,
        this.pinCode,
        this.collegeName,
        this.dateOfLastBloodDonation,
        this.isVerifiedPlasmaDonor});

  UserProfile.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    photoUrl = json['photo_url'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    bloodGroup = json['blood_group'];
    city = json['city'];
    pinCode = json['pin_code'];
    collegeName = json['college_name'];
    dateOfLastBloodDonation = json['date_of_last_blood_donation'];
    isVerifiedPlasmaDonor = json['is_verified_plasma_donor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['photo_url'] = this.photoUrl;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['blood_group'] = this.bloodGroup;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['college_name'] = this.collegeName;
    data['date_of_last_blood_donation'] = this.dateOfLastBloodDonation;
    data['is_verified_plasma_donor'] = this.isVerifiedPlasmaDonor;
    return data;
  }
}
