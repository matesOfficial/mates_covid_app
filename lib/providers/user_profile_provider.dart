
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier{
  UserProfile userProfile = UserProfile();
  // Private variable to check if the user stream is currently in loading state
  bool _isUserStreamLoading = true;
  // Getter for user stream
  bool get isUserStreamLoading =>_isUserStreamLoading;
  // private variable to check if the process to update to db is complete.
  bool _isUpdatingUserProfile = false;
  // Getter for user profile loading variable
  bool get isUpdatingUserProfile => _isUpdatingUserProfile;

  UserProfileProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null || user.uid == null) {
        // User is not logged in
        userProfile = null;
        notifyListeners();
        return;
      }

      // Stream user detail, update data when receive new data
      FirestoreDatabaseService.streamUser(user.uid).listen((event) {
        userProfile = event;
        // Initialize preferred books array
        _isUserStreamLoading = false;
        notifyListeners();
      });
    });
  }

  void updateName(String name){
    this.userProfile.name = name;
    notifyListeners();
  }

 void updateCity(String city){
    this.userProfile.city = city;
    notifyListeners();
 }

 void updatePinCode(int pinCode){
    this.userProfile.pinCode = pinCode;
    notifyListeners();
 }


 void updatePhoneNumber(String phoneNumber){
    this.userProfile.phoneNumber = phoneNumber;
    notifyListeners();
 }





  Future<void> updateUserProfile(String uid)async{
    _isUpdatingUserProfile = true;
    await FirestoreDatabaseService.updateUser(userProfile , uid);
    // TODO: Add try-catch for handling update auth info errors
    await AuthService.updateUserAuthInfo(userProfile);
    _isUpdatingUserProfile = false;
    notifyListeners();
  }

}