import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/already_registered_donor_screen.dart';
import 'package:covid_app/screens/blood_donation_form_screen.dart';
import 'package:covid_app/screens/consultation/consulting_bridge.dart';
import 'package:covid_app/screens/loading_screen.dart';
import 'package:covid_app/screens/plasma_donation_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);

    if (userProfileProvider.isUserStreamLoading) {
      return LoadingScreen();
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: Card(
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
                        "We got your back,\nwith all the covid \nresources. Find all \nthe help you need \nhere.",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            Text(
              "I want to donate",
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
                  InkWell(
                    onTap: () {
                      if (userProfileProvider.userProfileStream.isBloodDonor ==
                          true) {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlreadyRegisteredDonorScreen(
                              donorType: "BLOOD",
                            ),
                          ),
                        );
                      }
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BloodDonationFormScreen(),
                        ),
                      );
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
                  InkWell(
                    onTap: () {
                      if (userProfileProvider.userProfileStream.isPlasmaDonor ==
                          true) {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlreadyRegisteredDonorScreen(
                              donorType: "PLASMA",
                            ),
                          ),
                        );
                      }
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlasmaDonationFormScreen(),
                        ),
                      );
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
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('This feature is coming soon!.'),
                          backgroundColor: Colors.green,
                        ),
                      );
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
                              ImageConstants.oxygen_cylinder,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                            Padding(padding: EdgeInsets.all(10.0)),
                            Text("Oxygen"),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConsultancyBridge(),
                        ),
                      );
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
                            ImageConstants.consulting,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text("Consulting"),
                        ],
                      ),
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
