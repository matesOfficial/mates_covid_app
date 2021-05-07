import 'package:covid_app/global.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:covid_app/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile userProfile = UserProfile();
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
    this.userProfile.collegeName = name;
    notifyListeners();
  }

  void updateCityName(String name) {
    this.userProfile.city = name;
    notifyListeners();
  }

  void getLastCovidPositiveDate(DateTime date) {
    this.userProfile.lastCovidPositiveTimestamp =
        DateFormatter.convertDateTimeToTimestamp(date);
    notifyListeners();
  }

  void getLastBloodDonationDate(DateTime date){
    this.userProfile.lastBloodDonationTimestamp = DateFormatter.convertDateTimeToTimestamp(date);
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
        userProfile.collegeName == null ||
        userProfile.lastCovidPositiveTimestamp == null) {
      return false;
    }
    if (userProfile.pinCode.length < 6) {
      return false;
    }
    this.userProfile.isVerifiedPlasmaDonor = true;
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
        userProfile.collegeName == null ||
        userProfile.lastBloodDonationTimestamp == null) {
      return false;
    }
    if (userProfile.pinCode.length < 6) {
      logger.w("failed pin code");
      return false;
    }
    this.userProfile.isVerifiedBloodDonor = true;
    return true;
  }

  Future<void> updateUserProfile(String uid) async {
    _isUpdatingUserProfile = true;
    await FirestoreDatabaseService.updateUser(userProfile, uid);
    // TODO: Add try-catch for handling update auth info errors
    await AuthService.updateUserAuthInfo(userProfile);
    _isUpdatingUserProfile = false;
    notifyListeners();
  }

  void resetProvider(){
    this.userProfile = UserProfile();
    notifyListeners();
  }

}
