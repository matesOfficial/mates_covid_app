import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/models/doctor_model.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  DoctorModel doctorModel = new DoctorModel();
  DocumentSnapshot _lastDocument;
  bool _hasMore = true;
  List<DoctorModel> doctorsList =  List<DoctorModel>.empty(growable: true);
  // private variable to fetch data of donors.
  bool _isGettingDoctorListData = false;

  // Getter for get donors list loading variable
  bool get isGettingDoctorListData => _isGettingDoctorListData;


  void resetProvider(){
    this.doctorModel = DoctorModel();
    this.doctorsList = [];
  }

  void updateName(String name) {
    this.doctorModel.name = name;
    notifyListeners();
  }

  void updatePinCode(String pinCode) {
    this.doctorModel.pinCode = pinCode;
    notifyListeners();
  }

  void updateSpecialization(String specialization) {
    this.doctorModel.specialization = specialization;
    notifyListeners();
  }


  void updateServiceType(String serviceType) {
    this.doctorModel.serviceType = serviceType;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    this.doctorModel.phoneNumber = "+91$phoneNumber";
    notifyListeners();
  }

  void updateCityName(String name) {
    this.doctorModel.city = name;
    notifyListeners();
  }

  void updateStateName(String name) {
    this.doctorModel.state = name;
    notifyListeners();
  }

  void updateAssociatedHospital(String name){
    this.doctorModel.associatedHospital = name;
    notifyListeners();
  }

  /// validate doctor registration
  bool validateForm() {
    if (doctorModel.name == null ||
        doctorModel.city == null ||
        doctorModel.pinCode == null ||
        doctorModel.phoneNumber == null ||
        doctorModel.phoneNumber.length != 13 ||
        doctorModel.specialization == null ||
        doctorModel.serviceType == null ||
        doctorModel.associatedHospital == null) {
      return false;
    }
    if (doctorModel.pinCode.length < 6) {
      return false;
    }
    return true;
  }

  /// Get donor list data
  Future<void> getDoctorsListData(String city, String state) async {
    _isGettingDoctorListData = true;
    QuerySnapshot snapshot = await FirestoreDatabaseService.getDoctorsList(
        city: city,
        state: state,
        lastDocument: _lastDocument
    );
    _hasMore = snapshot.docs != null && snapshot.docs.length != 0;
    if (_hasMore == false) {
      print("no documents");
      _isGettingDoctorListData = false;
      notifyListeners();
      return;
    }
    doctorsList.addAll(
        snapshot.docs.map((e) => DoctorModel.fromJson(e.data()))
    );
    _lastDocument = snapshot.docs.last;
    _isGettingDoctorListData = false;
    notifyListeners();
  }





  /// upload doctor model to database  
  Future<void> updateDoctorInfo () => FirestoreDatabaseService.updateDoctorInfo(doctorModel);
}
