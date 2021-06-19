class PharmacyModel {
  String name;
  String city;
  String state;
  int pinCode;
  String phoneNumber;
  bool isHomeDeliveryAvailable;
  String operatingHours;

  PharmacyModel(
      {this.name,
      this.city,
      this.state,
      this.pinCode,
      this.phoneNumber,
      this.isHomeDeliveryAvailable,
      this.operatingHours});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pin_code'];
    phoneNumber = json['phone_number'];
    isHomeDeliveryAvailable = json['is_home_delivery_available'];
    operatingHours = json['operating_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['phone_number'] = this.phoneNumber;
    data['is_home_delivery_available'] = this.isHomeDeliveryAvailable;
    data['operating_hours'] = this.operatingHours;
    return data;
  }
}