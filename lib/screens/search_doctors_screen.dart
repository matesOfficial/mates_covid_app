import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/models/doctor_model.dart';
import 'package:covid_app/providers/doctor_provider.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/doctor_info_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:provider/provider.dart';


class SearchDoctorsScreen extends StatefulWidget {
  const SearchDoctorsScreen({Key key}) : super(key: key);

  @override
  _SearchDoctorsScreenState createState() => _SearchDoctorsScreenState();
}


class _SearchDoctorsScreenState extends State<SearchDoctorsScreen> {
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
                Provider.of<DoctorProvider>(context, listen: false).resetProvider();
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
                Provider.of<DoctorProvider>(context, listen: false)
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
        Provider.of<DoctorProvider>(context, listen: false)
            .getDoctorsListData(_selectedCity, _selectedState);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // pharmacy provider
    final DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context , listen: false);
    // get pharmacy list
    doctorProvider.getDoctorsListData(_selectedCity, _selectedState);
    // return page
    return WillPopScope(
      onWillPop: () {
        doctorProvider.resetProvider();
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
              Consumer<DoctorProvider>(
                builder: (context,doctorProvider , child) {
                  if (doctorProvider.doctorsList.isEmpty &&
                      doctorProvider.isGettingDoctorListData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  if (doctorProvider.doctorsList.isEmpty &&
                      doctorProvider.isGettingDoctorListData == false) {
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
                    itemCount: doctorProvider.doctorsList.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctorModel = doctorProvider.doctorsList[index];
                      return DoctorInfoListTile(
                        doctorModel: doctorModel,
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
