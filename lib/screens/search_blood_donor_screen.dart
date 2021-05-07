import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/text_box.dart';
import '../widgets/custom_list_tile.dart';

class SearchBloodDonorScreen extends StatefulWidget {
  @override
  _SearchBloodDonorScreenState createState() => _SearchBloodDonorScreenState();
}

class _SearchBloodDonorScreenState extends State<SearchBloodDonorScreen> {
  TextEditingController _cityController = TextEditingController();

  String selectedCity;

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
                  setState(() {
                    _cityController.text = e;
                    selectedCity = e;
                  });
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
        title: Text("Blood Donors"),
      ),
      // TODO: Re-factor this code, shift firebase query to database services
      body: StreamBuilder(
        stream: FirestoreDatabaseService.streamDonors(
            donorType: "is_verified_blood_donor", city: selectedCity),
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

          return SingleChildScrollView(
            child: Column(
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
                (snapshot.data == null || snapshot.data.docs.length == 0)
                    ? Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.3,
                        ),
                        Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "We are currently unable to find donors in your area. Hold on till something nice pops up!",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                      ],
                    )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userProfiles.length,
                        itemBuilder: (context, index) {
                          UserProfile user = userProfiles[index];
                          // if (selectedCity.toLowerCase() == user.city.toLowerCase()) {
                          //   print('Here0');
                          //   return CustomListCard(user: user);
                          // }

                          return CustomListCard(
                            user: user,
                            isPlasma: false,
                          );

                          print("here 3");
                          return null;
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomListTile {}
