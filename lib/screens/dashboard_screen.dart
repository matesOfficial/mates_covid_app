import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/screens/blood_donation_form_screen.dart';
import 'package:covid_app/screens/plasma_donation_form_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  // can have value as DONOR or RECEIVER
  final String userType;

  DashboardScreen({@required this.userType});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                color: Color(0xffFAB550),
                height: 173,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.all(10.0)),
                    Image.asset(
                      ImageConstants.lookingfordonor_mainillustration,
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(
                      "We got your back,\n with all the covid \nresources. Find all \nthe help you need \nhere.",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            Text(
              widget.userType == "RECEIVER"
                  ? "I am looking for"
                  : "I want to donate",
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (widget.userType == "DONOR") {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonationFormScreen(),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(0xffFFFFFF),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10.0)),
                          Image.asset(
                            ImageConstants.blood_drop,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text("Blood"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.userType == "DONOR") {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlasmaDonationFormScreen(),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(0xffFFFFFF),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10.0)),
                          Image.asset(
                            ImageConstants.plasma_drop,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text("Plasma"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(0xffFFFFFF),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10.0)),
                          Image.asset(
                            ImageConstants.oxygen_cylinder,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text("Oxygen"),
                        ],
                      )),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xffFFFFFF),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Image.asset(
                          ImageConstants.consulting,
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text("Consulting"),
                      ],
                    ),
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
