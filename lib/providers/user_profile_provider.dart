import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/global.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:covid_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile userProfile = UserProfile();
  List<UserProfile> donorsList = List<UserProfile>.empty(growable: true);
  DocumentSnapshot _lastDocumet;
  bool _hasMore = true;

  // private variable to fetch data of donors.
  bool _isGettingDonorListData = false;

  // Getter for get donors list loading variable
  bool get isGettingDonorListData => _isGettingDonorListData;

  // private variable to check if the process to update to db is complete.
  bool _isUpdatingUserProfile = false;

  // Getter for user profile loading variable
  bool get isUpdatingUserProfile => _isUpdatingUserProfile;

  /// Functions to get user details as input

  void updateName(String name) {
    this.userProfile.name = name;
    notifyListeners();
  }

  void updateCity(String city) {
    this.userProfile.city = city;
    notifyListeners();
  }

  void updatePinCode(String pinCode) {
    this.userProfile.pinCode = pinCode;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    this.userProfile.phoneNumber = "+91$phoneNumber";
    notifyListeners();
  }

  void updateBloodGroup(String bloodGroup) {
    this.userProfile.bloodGroup = bloodGroup;
    notifyListeners();
  }

  void updateCollegeName(String name) {
    this.userProfile.matesAffiliation = name;
    notifyListeners();
  }

  void updateCityName(String name) {
    this.userProfile.city = name;
    notifyListeners();
  }

  void updateStateName(String name) {
    this.userProfile.state = name;
    notifyListeners();
  }

  void getLastCovidPositiveDate(DateTime date) {
    this.userProfile.lastCovidPositiveDate =
        DateFormatter.convertDateTimeToTimestamp(date);
    notifyListeners();
  }

  void getLastBloodDonationDate(DateTime date) {
    this.userProfile.lastBloodDonationDate =
        DateFormatter.convertDateTimeToTimestamp(date);
    notifyListeners();
  }

  /// validate plasma form function
  bool validatePlasmaForm() {
    if (userProfile.name == null ||
        userProfile.city == null ||
        userProfile.pinCode == null ||
        userProfile.phoneNumber == null ||
        userProfile.phoneNumber.length != 13 ||
        userProfile.bloodGroup == null ||
        userProfile.matesAffiliation == null ||
        userProfile.lastCovidPositiveDate == null) {
      return false;
    }
    if (userProfile.pinCode.length < 6) {
      return false;
    }
    this.userProfile.isPlasmaDonor = true;
    return true;
  }

  /// validate blood donation form form function
  bool validateBloodDonationForm() {
    if (userProfile.name == null ||
        userProfile.city == null ||
        userProfile.pinCode == null ||
        userProfile.phoneNumber == null ||
        userProfile.phoneNumber.length != 13 ||
        userProfile.bloodGroup == null ||
        userProfile.matesAffiliation == null) {
      return false;
    }
    if (userProfile.pinCode.length < 6) {
      logger.w("failed pin code");
      return false;
    }
    this.userProfile.isBloodDonor = true;
    return true;
  }

  Future<void> updateUserProfile(String uid) async {
    _isGettingDonorListData = true;
    await FirestoreDatabaseService.updateUser(userProfile, uid);
    // TODO: Add try-catch for handling update auth info errors
    await AuthService.updateUserAuthInfo(userProfile);
    _isGettingDonorListData = false;
    notifyListeners();
  }

  /// Get donor list data
  Future<void> getDonorListData(String donorType, String timestampType,
      String city, String state) async {
    _isGettingDonorListData = true;
    QuerySnapshot snapshot = await FirestoreDatabaseService.getDonorsList(
      donorType: donorType,
      timestampType: timestampType,
      city: city,
      state: state,
      lastDocument: _lastDocumet
    );
    _hasMore = snapshot.docs != null && snapshot.docs.length != 0;
    if (_hasMore == false) {
      print("no documents");
      _isGettingDonorListData = false;
      notifyListeners();
      return;
    }

    donorsList.addAll(
        snapshot.docs.map((e) => UserProfile.fromJson(e.data()))
    );
    _lastDocumet = snapshot.docs.last;
    _isGettingDonorListData = false;
    notifyListeners();
  }

  void resetProvider() {
    this.userProfile = UserProfile();
    donorsList.clear();
    _hasMore = true;
    _lastDocumet = null;
    notifyListeners();
  }
}
