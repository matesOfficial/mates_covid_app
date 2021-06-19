import 'package:covid_app/models/doctor_model.dart';
import 'package:covid_app/models/pharmacy_model.dart';
import 'package:flutter/material.dart';

class PharmacyInfoListTile extends StatelessWidget {
  final PharmacyModel pharmacyModel;

  const PharmacyInfoListTile({Key key, this.pharmacyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    pharmacyModel.name,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    pharmacyModel.city,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Phone No.",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Home Delivery :", textAlign: TextAlign.right),
                      Text(pharmacyModel.isHomeDeliveryAvailable ? "Yes" : "No",
                          style: TextStyle(color: Color(0xffFAB550)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pharmacyModel.pinCode,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xffFAB550))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pharmacyModel.phoneNumber.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xffFAB550))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
