import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/search_blood_donor_screen.dart';
import 'package:covid_app/screens/search_plasma_donor_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            onTap: (value) {
              Provider.of<UserProfileProvider>(context, listen: false)
                  .resetProvider();
            },
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
          physics: NeverScrollableScrollPhysics(),
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
