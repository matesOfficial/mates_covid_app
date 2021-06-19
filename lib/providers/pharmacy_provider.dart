import 'package:covid_app/models/pharmacy_model.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';

class PharmacyProvider extends ChangeNotifier{
  PharmacyModel pharmacyModel = new PharmacyModel();

  void resetProvider(){
    this.pharmacyModel = PharmacyModel();
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

  Future<void> updatePharmacyInfo () => FirestoreDatabaseService.updatePharmacyInfo(pharmacyModel);

}