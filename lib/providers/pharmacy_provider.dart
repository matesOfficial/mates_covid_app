import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/models/pharmacy_model.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';

class PharmacyProvider extends ChangeNotifier{
  PharmacyModel pharmacyModel = new PharmacyModel();
  DocumentSnapshot _lastDocument;
  bool _hasMore = true;
  List<PharmacyModel> pharmacyList = List<PharmacyModel>.empty(growable: true);
  // private variable to fetch data of donors.
  bool _isGettingPharmacyListData = false;

  // Getter for get donors list loading variable
  bool get isGettingPharmacyListData => _isGettingPharmacyListData;


  void resetProvider(){
    this.pharmacyModel = PharmacyModel();
    this.pharmacyList = [];
  }
  
  void updateName(String name) {
    this.pharmacyModel.name = name;
    notifyListeners();
  }

  void updatePinCode(String pinCode) {
    this.pharmacyModel.pinCode = pinCode;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    this.pharmacyModel.phoneNumber = "+91$phoneNumber";
    notifyListeners();
  }

  void updateCityName(String name) {
    this.pharmacyModel.city = name;
    notifyListeners();
  }

  void updateStateName(String name) {
    this.pharmacyModel.state = name;
    notifyListeners();
  }

  void updateOperatingHours(String hours){
    this.pharmacyModel.operatingHours = hours;
    notifyListeners();
  }

  void updateIsHomeDeliveryAvailable(String available){
    if(available == "Yes"){
      this.pharmacyModel.isHomeDeliveryAvailable = true;
    }
    else{
      this.pharmacyModel.isHomeDeliveryAvailable = false;
    }
    notifyListeners();
  }



  /// validate pharmacy registration
  bool validateForm() {
    if (pharmacyModel.name == null ||
        pharmacyModel.city == null ||
        pharmacyModel.pinCode == null ||
        pharmacyModel.phoneNumber == null ||
        pharmacyModel.phoneNumber.length != 13 ||
       pharmacyModel.isHomeDeliveryAvailable == null || pharmacyModel.operatingHours == null) {
      return false;
    }
    if (pharmacyModel.pinCode.length < 6) {
      return false;
    }
    return true;
  }

  /// Get donor list data
  Future<void> getPharmacyListData(String city, String state) async {
    _isGettingPharmacyListData = true;
    QuerySnapshot snapshot = await FirestoreDatabaseService.getPharmacyList(
        city: city,
        state: state,
        lastDocument: _lastDocument
    );
    _hasMore = snapshot.docs != null && snapshot.docs.length != 0;
    if (_hasMore == false) {
      print("no documents");
      _isGettingPharmacyListData = false;
      notifyListeners();
      return;
    }
    pharmacyList.addAll(
        snapshot.docs.map((e) => PharmacyModel.fromJson(e.data()))
    );
    _lastDocument = snapshot.docs.last;
    _isGettingPharmacyListData = false;
    notifyListeners();
  }

  Future<void> updatePharmacyInfo () => FirestoreDatabaseService.updatePharmacyInfo(pharmacyModel);

}