import 'package:covid_app/screens/search_blood_donor_screen.dart';
import 'package:covid_app/screens/search_plasma_donor_screen.dart';
import 'package:flutter/material.dart';

class SearchDonorsScreen extends StatelessWidget {
  const SearchDonorsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Search Donors"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Oxygen",
              ),
              Tab(
                text: "Blood",
              ),
              Tab(
                text: "Plasma",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchBloodDonorScreen(),
            SearchBloodDonorScreen(),
            SearchPlasmaDonorScreen()
          ],
        ),
      ),
    );
  }
}
