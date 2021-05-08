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
  String name;
  String state;
  String photoUrl;
  String email;
  String uid;
  String gender;
  String phoneNumber;
  String bloodGroup;
  String city;
  String pinCode;
  String matesAffiliation;
  Timestamp lastBloodDonationDate;
  bool isPlasmaDonor;
  bool isBloodDonor;
  Timestamp timestamp;
  Timestamp lastCovidPositiveDate;

  UserProfile(
      {this.name,
      this.photoUrl,
      this.email,
      this.uid,
      this.gender,
      this.phoneNumber,
      this.bloodGroup,
      this.state,
      this.city,
      this.pinCode,
      this.matesAffiliation,
      this.lastBloodDonationDate,
      this.isPlasmaDonor,
      this.isBloodDonor,
      this.lastCovidPositiveDate});

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photoUrl = json['photo_url'];
    email = json['email'];
    uid = json['uid'];
    state = json['state'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    bloodGroup = json['blood_group'];
    city = json['city'];
    timestamp = json['timestamp'];
    pinCode = json['pin_code'];
    matesAffiliation = json['mates_affiliation'];
    lastBloodDonationDate = json['last_blood_donation_date'];
    isPlasmaDonor = json['is_plasma_donor'];
    isBloodDonor = json['is_blood_donor'];
    lastCovidPositiveDate = json['last_covid_positive_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) data['name'] = this.name;
    if (this.photoUrl != null) data['photo_url'] = this.photoUrl;
    if (this.state != null) data['state'] = this.state;
    if (this.email != null) data['email'] = this.email;
    if (this.uid != null) data['uid'] = this.uid;
    if (this.timestamp != null) data['timestamp'] = Timestamp.now();
    if (this.gender != null) data['gender'] = this.gender;
    if (this.phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (this.bloodGroup != null) data['blood_group'] = this.bloodGroup;
    if (this.city != null) data['city'] = this.city;
    if (this.pinCode != null) data['pin_code'] = this.pinCode;
    if (this.matesAffiliation != null)
      data['mates_affiliation'] = this.matesAffiliation;
    if (this.lastBloodDonationDate != null)
      data['last_blood_donation_date'] = this.lastBloodDonationDate;
    if (this.isBloodDonor != null) data['is_plasma_donor'] = this.isPlasmaDonor;
    if (this.isPlasmaDonor != null) data['is_blood_donor'] = this.isBloodDonor;
    if (this.lastCovidPositiveDate != null)
      data['last_covid_positive_date'] = this.lastCovidPositiveDate;
    return data;
  }
}
