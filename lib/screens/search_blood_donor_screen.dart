import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
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
  TextEditingController _stateController = TextEditingController();
  ScrollController _scrollController = ScrollController();

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
                    // reset user profile provider
                    Provider.of<UserProfileProvider>(context, listen: false).resetProvider();
                    _selectedState = e;
                    _stateController.text = e;
                    _cityController.text = "";
                    _selectedCity = null;
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
                    // reset user profile provider
                    Provider.of<UserProfileProvider>(context, listen: false).resetProvider();
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
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Gives value of how far user can scroll
      double _maxScroll = _scrollController.position.maxScrollExtent;
      // Current scroll position of the user
      double _currentScroll = _scrollController.position.pixels;
      // compare max scroll extent and current position
      //   double delta = MediaQuery.of(context).size.height * 10;
      if (_maxScroll == _currentScroll) {
        print("scroll");
        Provider.of<UserProfileProvider>(context, listen: false)
            .getDonorListData("is_blood_donor", "last_blood_donation_date",
                _selectedCity, _selectedState);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // user profile provider
    final UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    // call get donors list function
    userProfileProvider.getDonorListData("is_blood_donor",
        "last_blood_donation_date", _selectedCity, _selectedState);
    // return page
    return WillPopScope(
      onWillPop: (){
        userProfileProvider.resetProvider();
        Navigator.pop(context);
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text("Blood Donors"),
        // ),
        body: SingleChildScrollView(
          controller: _scrollController,
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
                  onTap: () => _selectedState == null
                      ? null
                      : _showSelectCityDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),
              Consumer<UserProfileProvider>(
                builder: (context, userProfileProvider, child) {
                  if (userProfileProvider.donorsList.isEmpty &&
                      userProfileProvider.isGettingDonorListData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (userProfileProvider.donorsList.isEmpty &&
                      userProfileProvider.isGettingDonorListData == false) {
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

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userProfileProvider.donorsList.length,
                    itemBuilder: (context, index) {
                      UserProfile user = userProfileProvider.donorsList[index];
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
      ),
    );
  }
}
