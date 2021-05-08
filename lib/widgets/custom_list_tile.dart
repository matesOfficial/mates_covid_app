import 'package:covid_app/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {
  final UserProfile user;
  final bool isPlasma;
  CustomListCard({this.user, this.isPlasma});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
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
                      user.name,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user.city,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (user.lastBloodDonationDate != null &&
                      isPlasma == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date of last donation :",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  if (user.lastCovidPositiveDate != null &&
                      isPlasma == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date of covid positive report :",
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
                        Text("Blood Group :", textAlign: TextAlign.right),
                        Text(" ${user.bloodGroup}",
                            style: TextStyle(color: Color(0xffFAB550)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.pinCode,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xffFAB550))),
                  ),
                  if (user.lastBloodDonationDate != null &&
                      isPlasma == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          user.lastBloodDonationDate
                              .toDate()
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                          style: TextStyle(color: Color(0xffFAB550)),
                          textAlign: TextAlign.right),
                    ),
                  if (user.lastCovidPositiveDate != null &&
                      isPlasma == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.lastCovidPositiveDate
                            .toDate()
                            .toLocal()
                            .toString()
                            .split(' ')[0],
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xffFAB550)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.phoneNumber.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xffFAB550))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
