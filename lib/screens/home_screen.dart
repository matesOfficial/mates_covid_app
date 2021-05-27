import 'package:covid_app/screens/dashboard_screen.dart';
import 'package:covid_app/screens/search_blood_donor_screen.dart';
import 'package:covid_app/screens/search_donors_screen.dart';
import 'package:covid_app/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // stores current index form bottom navigation bar
  int _currentIndex = 0;

  // List of widgets which can be switched via BNB
  List<Widget> _homeScreenWidgets = [
    SearchDonorsScreen(),
    DashboardScreen(userType: "DONOR"),
    SearchBloodDonorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // main body to display
     body: _homeScreenWidgets[_currentIndex],
      // App Footer
      bottomNavigationBar: MyBottomNavigationBar(
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
