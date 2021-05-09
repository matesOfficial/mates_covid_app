import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:flutter/material.dart';
import '../widgets/text_box.dart';
import '../widgets/custom_list_tile.dart';

class SearchBloodDonorScreen extends StatefulWidget {
  @override
  _SearchBloodDonorScreenState createState() => _SearchBloodDonorScreenState();
}

class _SearchBloodDonorScreenState extends State<SearchBloodDonorScreen> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  String _selectedCity;
  String _selectedState;

  Future<void> _showSelectStateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your state name",
        children: AppConstants.STATES_CITIES_MAP.keys
            .toList()
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  setState(() {
                    _selectedState = e;
                    _stateController.text = e;
                  });
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showSelectCityDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your city name",
        children: AppConstants.STATES_CITIES_MAP[_selectedState]
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  setState(() {
                    _cityController.text = e;
                    _selectedCity = e;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: TextBox(
                hintText: "State",
                readOnly: true,
                controller: _stateController,
                onTap: () => _showSelectStateDialog(context),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: TextBox(
                hintText: "City",
                readOnly: true,
                controller: _cityController,
                onTap: () => _selectedState == null ? null :_showSelectCityDialog(context),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirestoreDatabaseService.streamDonors(
                donorType: "is_blood_donor",
                timestampType: "last_blood_donation_date",
                city: _selectedCity,
                state: _selectedState,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                  );
                }
                if (snapshot.data.docs.length == 0)
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                  );
                var snapshotData = snapshot.data.docs;
                List<UserProfile> userProfiles =
                    List.from(snapshotData.map((doc) {
                  return UserProfile.fromJson(doc.data());
                }));
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userProfiles.length,
                  itemBuilder: (context, index) {
                    UserProfile user = userProfiles[index];
                    return CustomListCard(
                      user: user,
                      isPlasma: false,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
