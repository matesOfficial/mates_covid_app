import 'package:covid_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database_service.dart';

class AuthService {
  // Instance variable
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream listening to auth changes
  static Stream<UserModel> get authStream {
    return _firebaseAuth
        .authStateChanges()
        .map((u) => UserModel.fromFirebase(firebaseData: u));
  }

  static Future<void> signInWithPhone(
    String phoneNumber, {
    @required PhoneVerificationCompleted onAutoPhoneVerificationCompleted,
    @required PhoneVerificationFailed onPhoneVerificationFailed,
    @required PhoneCodeSent onPhoneCodeSent,
  }) async {
    return await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onAutoPhoneVerificationCompleted,
      verificationFailed: onPhoneVerificationFailed,
      codeSent: onPhoneCodeSent,
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// Verify after fetching the OTP
  static Future<bool> verifyOTP(String verificationId, String otp) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    UserCredential result;
    try {
      result = await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      // throw e;
      return false;
    }

    if (result.user.uid != null) {
      if (result.additionalUserInfo.isNewUser) {
        // Add the information of newly created user to database.
        final UserModel newUser =
            UserModel.fromFirebase(firebaseData: result.user);
        FirestoreDatabaseService.createNewUser(newUser);
      }
      return true;
    }
    return false;
  }

  static Future<void> logOut() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  /// Handles error and returns error messages in all cases.
  static String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Please use a different email to continue.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "This user has been disabled by an administrator.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      case "invalid-verification-code":
        return "The OTP you entered was invalid";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }

  static Future<void> updateUserAuthInfo(UserProfile user)async{
    await _firebaseAuth.currentUser.updateProfile(displayName: user.name);
    await _firebaseAuth.currentUser.updateEmail(user.email);
  }

}
