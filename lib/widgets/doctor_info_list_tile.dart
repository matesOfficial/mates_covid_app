import 'package:covid_app/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorInfoListTile extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorInfoListTile({ Key key, this.doctorModel }) : super(key: key);

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
                      doctorModel.name,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      doctorModel.city,
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
                        Text("Hospital :", textAlign: TextAlign.right),
                        Text(" ${doctorModel.associatedHospital}",
                            style: TextStyle(color: Color(0xffFAB550)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(doctorModel.pinCode,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xffFAB550))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(doctorModel.phoneNumber.toString(),
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