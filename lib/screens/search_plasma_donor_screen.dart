import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/user_model.dart';
import '../models/user_model.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/multi_select_dialog.dart';
import '../widgets/text_box.dart';

class SearchPlasmaDonorScreen extends StatefulWidget {
  @override
  _SearchPlasmaDonorScreenState createState() =>
      _SearchPlasmaDonorScreenState();
}

class _SearchPlasmaDonorScreenState extends State<SearchPlasmaDonorScreen> {
  TextEditingController _cityController = TextEditingController();
  Future<void> _showSelectCityDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your city name",
        children: AppConstants.CITIES_LIST
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Plasma Donors"),
      ),
      // TODO: Re-factor this code, shift firebase query to database services
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('is_verified_plasma_donor', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          }
          var snapshotData = snapshot.data.docs;
          print(snapshotData);
          List<UserProfile> userProfiles = List.from(snapshotData.map((doc) {
            return UserProfile.fromJson(doc.data());
          }));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No donor found"));
          }

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: TextBox(
                  hintText: "City",
                  readOnly: true,
                  controller: _cityController,
                  onTap: () => _showSelectCityDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userProfiles.length,
                itemBuilder: (context, index) {
                  UserProfile user = userProfiles[index];
                  return CustomListCard(
                    user: user,
                    isPlasma: true,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
