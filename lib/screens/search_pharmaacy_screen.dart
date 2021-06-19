import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/models/pharmacy_model.dart';
import 'package:covid_app/providers/pharmacy_provider.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/pharmacy_info_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:provider/provider.dart';

class SearchPharmacyScreen extends StatefulWidget {
  const SearchPharmacyScreen({Key key}) : super(key: key);

  @override
  _SearchPharmacyScreenState createState() => _SearchPharmacyScreenState();
}


class _SearchPharmacyScreenState extends State<SearchPharmacyScreen> {
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
                Provider.of<PharmacyProvider>(context, listen: false)
                    .resetProvider();
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
                Provider.of<PharmacyProvider>(context, listen: false)
                    .resetProvider();
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
        Provider.of<PharmacyProvider>(context, listen: false)
            .getPharmacyListData(_selectedCity, _selectedState);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // pharmacy provider
    final PharmacyProvider pharmacyProvider = Provider.of<PharmacyProvider>(context , listen: false);
    // get pharmacy list
    pharmacyProvider.getPharmacyListData(_selectedCity, _selectedState);
    // return page
    return WillPopScope(
      onWillPop: () {
        pharmacyProvider.resetProvider();
        Navigator.pop(context);
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
              Consumer<PharmacyProvider>(
                builder: (context,pharmacyProvider , child) {
                  if (pharmacyProvider.pharmacyList.isEmpty &&
                      pharmacyProvider.isGettingPharmacyListData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  if (pharmacyProvider.pharmacyList.isEmpty &&
                      pharmacyProvider.isGettingPharmacyListData == false) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
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
                    itemCount: pharmacyProvider.pharmacyList.length,
                    itemBuilder: (context, index) {
                      PharmacyModel pharmacy = pharmacyProvider.pharmacyList[index];
                      return PharmacyInfoListTile(
                        pharmacyModel: pharmacy,
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
