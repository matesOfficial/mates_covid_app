import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String name;
  String state;
  String city;
  String pinCode;
  String phoneNumber;
  String specialization;
  String serviceType;
  Timestamp registrationTimestamp;
  String associatedHospital;

  DoctorModel(
      {this.name,
      this.state,
      this.registrationTimestamp,
      this.city,
      this.pinCode,
      this.phoneNumber,
      this.specialization,
      this.serviceType,
      this.associatedHospital});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    state = json['state'];
    registrationTimestamp = json["registration_timestamp"];
    city = json['city'];
    pinCode = json['pin_code'];
    phoneNumber = json['phone_number'];
    specialization = json['specialization'];
    serviceType = json['service_type'];
    associatedHospital = json['associated_hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data["registration_timestamp"] = DateTime.now();
    data['state'] = this.state;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['phone_number'] = this.phoneNumber;
    data['specialization'] = this.specialization;
    data['service_type'] = this.serviceType;
    data['associated_hospital'] = this.associatedHospital;
    return data;
  }
}