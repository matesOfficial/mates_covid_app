import 'package:covid_app/global.dart';
import 'package:covid_app/models/doctor_model.dart';
import 'package:covid_app/models/pharmacy_model.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDatabaseService {
  /// Firestore instance variable
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  /// Create a new user in db
  static Future<void> createNewUser(UserModel newUser) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.uid)
        .set(newUser.toJson());
  }

  /// Update existing user
  static Future<void> updateUser(UserProfile userProfile, String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(userProfile.toJson());
  }

  /// Stream user from firestore
  static Stream<UserProfile> streamUser(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserProfile.fromJson(event.data()));
  }

  /// Return object of user profile.
  static Future<UserProfile> getUser(String userId) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserProfile.fromJson(data.data());
  }

  /// Create a new user profile in db
  static Future<void> createNewUserProfile(String uid, UserProfile newUser) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(newUser.toJson());
  }

  static Stream<QuerySnapshot> streamDonors(
      {String city,
      String state,
      @required String donorType,
      @required String timestampType}) {
    if (city != null && state == null) {
      return FirebaseFirestore.instance
          .collection('users')
          .where(donorType, isEqualTo: true)
          .where("city", isEqualTo: city)
          .orderBy(timestampType, descending: false)
          .snapshots();
    }
    if (city == null && state != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .where(donorType, isEqualTo: true)
          .where("state", isEqualTo: state)
          .orderBy(timestampType, descending: false)
          .snapshots();
    } else if (city != null && state != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .where(donorType, isEqualTo: true)
          .where("city", isEqualTo: city)
          .where("state", isEqualTo: state)
          .orderBy(timestampType, descending: false)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .where(donorType, isEqualTo: true)
        .orderBy(timestampType, descending: false)
        .snapshots();
  }

  static Future<QuerySnapshot> getDonorsList(
      {String city,
      String state,
      @required String donorType,
      @required String timestampType,
      DocumentSnapshot lastDocument}) {
    if (lastDocument == null) {
      if (city != null && state == null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("city", isEqualTo: city)
            .orderBy(timestampType, descending: false)
            .limit(DONORS_LIST_PAGINATION_LIMIT)
            .get();
      }
      if (city == null && state != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("state", isEqualTo: state)
            .orderBy(timestampType, descending: false)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      } else if (city != null && state != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("city", isEqualTo: city)
            .where("state", isEqualTo: state)
            .orderBy(timestampType, descending: false)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      }
      return FirebaseFirestore.instance
          .collection('users')
          .where(donorType, isEqualTo: true)
          .orderBy(timestampType, descending: false)
          .limit( DONORS_LIST_PAGINATION_LIMIT )
          .get();
    } else {
      if (city != null && state == null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("city", isEqualTo: city)
            .orderBy(timestampType, descending: false)
            .startAfterDocument(lastDocument)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      }
      if (city == null && state != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("state", isEqualTo: state)
            .orderBy(timestampType, descending: false)
            .startAfterDocument(lastDocument)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      } else if (city != null && state != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .where(donorType, isEqualTo: true)
            .where("city", isEqualTo: city)
            .where("state", isEqualTo: state)
            .orderBy(timestampType, descending: false)
            .startAfterDocument(lastDocument)
            .limit( DONORS_LIST_PAGINATION_LIMIT)
            .get();
      }
      return FirebaseFirestore.instance
          .collection('users')
          .where(donorType, isEqualTo: true)
          .orderBy(timestampType, descending: false)
          .startAfterDocument(lastDocument)
          .limit( DONORS_LIST_PAGINATION_LIMIT )
          .get();
    }
  }

  /// Upload doctor model information to database
  static Future<void> updateDoctorInfo(DoctorModel doctorModel){
      return FirebaseFirestore.instance.collection("doctors").add(doctorModel.toJson());
  }

 /// Upload pharmacy model information to database
 static Future<void> updatePharmacyInfo(PharmacyModel pharmacyModel){
   return FirebaseFirestore.instance.collection("pharmacies").add(pharmacyModel.toJson());
 }
/// Get phsrmscy list
 static Future<QuerySnapshot> getPharmacyList({
  String city,
   String state,
   DocumentSnapshot lastDocument
}){
   if (lastDocument == null) {
     if (city != null && state == null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("city", isEqualTo: city)
           .limit(DONORS_LIST_PAGINATION_LIMIT)
           .get();
     }
     if (city == null && state != null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("state", isEqualTo: state)
           .limit( DONORS_LIST_PAGINATION_LIMIT )
           .get();
     } else if (city != null && state != null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("city", isEqualTo: city)
           .where("state", isEqualTo: state)
           .limit( DONORS_LIST_PAGINATION_LIMIT )
           .get();
     }
     return FirebaseFirestore.instance
         .collection('pharmacies')
         .limit( DONORS_LIST_PAGINATION_LIMIT )
         .get();

   } else {
     if (city != null && state == null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("city", isEqualTo: city)
           .startAfterDocument(lastDocument)
           .limit(DONORS_LIST_PAGINATION_LIMIT)
           .get();
     }
     if (city == null && state != null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("state", isEqualTo: state)
           .startAfterDocument(lastDocument)
           .limit(DONORS_LIST_PAGINATION_LIMIT)
           .get();
     } else if (city != null && state != null) {
       return FirebaseFirestore.instance
           .collection('pharmacies')
           .where("city", isEqualTo: city)
           .where("state", isEqualTo: state)
           .startAfterDocument(lastDocument)
           .limit(DONORS_LIST_PAGINATION_LIMIT)
           .get();
     }
     return FirebaseFirestore.instance
         .collection('pharmacies')
         .startAfterDocument(lastDocument)
         .limit(DONORS_LIST_PAGINATION_LIMIT)
         .get();
   }
 }
/// Get doctors list
  static Future<QuerySnapshot> getDoctorsList({
    String city,
    String state,
    DocumentSnapshot lastDocument
  }){
    if (lastDocument == null) {
      if (city != null && state == null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("city", isEqualTo: city)
            .limit(DONORS_LIST_PAGINATION_LIMIT)
            .get();
      }
      if (city == null && state != null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("state", isEqualTo: state)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      } else if (city != null && state != null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("city", isEqualTo: city)
            .where("state", isEqualTo: state)
            .limit( DONORS_LIST_PAGINATION_LIMIT )
            .get();
      }
      return FirebaseFirestore.instance
          .collection('doctors')
          .limit( DONORS_LIST_PAGINATION_LIMIT )
          .get();

    } else {
      if (city != null && state == null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("city", isEqualTo: city)
            .startAfterDocument(lastDocument)
            .limit(DONORS_LIST_PAGINATION_LIMIT)
            .get();
      }
      if (city == null && state != null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("state", isEqualTo: state)
            .startAfterDocument(lastDocument)
            .limit(DONORS_LIST_PAGINATION_LIMIT)
            .get();
      } else if (city != null && state != null) {
        return FirebaseFirestore.instance
            .collection('doctors')
            .where("city", isEqualTo: city)
            .where("state", isEqualTo: state)
            .startAfterDocument(lastDocument)
            .limit(DONORS_LIST_PAGINATION_LIMIT)
            .get();
      }
      return FirebaseFirestore.instance
          .collection('doctors')
          .startAfterDocument(lastDocument)
          .limit(DONORS_LIST_PAGINATION_LIMIT)
          .get();
    }
  }


}
