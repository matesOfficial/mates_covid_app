import 'package:covid_app/constants/image_constants.dart';
import 'package:flutter/material.dart';

class DashboardDonor extends StatefulWidget {
  @override
  _DashboardDonorState createState() => _DashboardDonorState();
}

class _DashboardDonorState extends State<DashboardDonor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {},
            );
          },
        ),
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
                          ImageConstants.iamadonor_mainillustration,
                          width: 180,
                          fit: BoxFit.contain,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          "Costs You Nothing,\n But It Can Mean \nThe World To \nSomeone In Need.",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ))),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            Text("I want to donate"),
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
                Card(
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
                          ImageConstants.plasma_drop,
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text("Plasma"),
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
                    )),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
