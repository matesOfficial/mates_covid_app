class OxygenModel {
  String supplyType;
  String donorId;
  int quantity;
  String city;
  int pinCode;

  OxygenModel(
      {this.supplyType, this.donorId, this.quantity, this.city, this.pinCode});

  OxygenModel.fromJson(Map<String, dynamic> json) {
    supplyType = json['supply_type'];
    donorId = json['donor_id'];
    quantity = json['quantity'];
    city = json['city'];
    pinCode = json['pin_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supply_type'] = this.supplyType;
    data['donor_id'] = this.donorId;
    data['quantity'] = this.quantity;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    return data;
  }
}