import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/global.dart';
import 'package:covid_app/providers/doctor_provider.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/otp_screen.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/utils/date_formatter.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  @override
  _DoctorRegistrationScreenState createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  // loading state variable
  bool _isLoading = false;

  // text editng controllers
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _specializationController = new TextEditingController();
  TextEditingController _serviceTypeController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // user profile provider
    final DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    // Set text for controllers
    _nameController.text = doctorProvider.doctorModel.name;
    _cityController.text = doctorProvider.doctorModel.city;
    _stateController.text = doctorProvider.doctorModel.state;
    _serviceTypeController.text = doctorProvider.doctorModel.serviceType;
    _specializationController.text = doctorProvider.doctorModel.specialization;
    _phoneController.text = doctorProvider.doctorModel.phoneNumber;


    return WillPopScope(
      onWillPop: () {
        doctorProvider.resetProvider();
        Navigator.pop(context);
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Doctor"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Image.asset(
                      ImageConstants.consulting,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 13),
                  child: TextBox(
                    hintText: "Name",
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => doctorProvider.updateName(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
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
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "City",
                    readOnly: true,
                    controller: _cityController,
                    onTap: () => doctorProvider.doctorModel.state == null
                        ? null
                        : _showSelectCityDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Pin Code",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onChanged: (value) => doctorProvider.updatePinCode(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) =>
                        doctorProvider.updatePhoneNumber(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Specialization",
                    keyboardType: TextInputType.name,
                    controller: _specializationController,
                    readOnly: true,
                    onTap: () => _showSpecializationDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    hintText: "Paid/Free",
                    readOnly: true,
                    controller: _serviceTypeController,
                    onTap: () => _showFreePaidDialog(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 32,
                  ),
                  child: TextBox(
                    onChanged: (value) => doctorProvider.updateAssociatedHospital(value),
                    hintText: "Hospital Associated With",
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32.0),
                  child: BottomButton(
                    loadingState: _isLoading,
                    disabledState: false,
                    child: Text("Continue"),
                    onPressed: () => _onSubmitDetails(doctorProvider, context),
                  ),
                ),
                SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSpecializationDialog(BuildContext context) {
    final DoctorProvider doctorProvider =
        Provider.of<DoctorProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your specialization",
        children: AppConstants.DOCTOR_SPECIALIZATION
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  doctorProvider.updateSpecialization(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showSelectStateDialog(BuildContext context) {
    final DoctorProvider doctorProvider =
        Provider.of<DoctorProvider>(context, listen: false);
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
                  doctorProvider.updateStateName(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showFreePaidDialog(BuildContext context) {
    final DoctorProvider doctorProvider =
        Provider.of<DoctorProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Free or Paid",
        children: AppConstants.FREE_PAID
            .map(
              (e) => MultiSelectDialogItem(
                text: e,
                onPressed: () {
                  doctorProvider.updateServiceType(e);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showSelectCityDialog(BuildContext context) {
    final DoctorProvider doctorProvider =
        Provider.of<DoctorProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your city name",
        children:
            AppConstants.STATES_CITIES_MAP[doctorProvider.doctorModel.state]
                .map(
                  (e) => MultiSelectDialogItem(
                    text: e,
                    onPressed: () {
                      doctorProvider.updateCityName(e);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  Future<void> _onSubmitDetails(
      DoctorProvider doctorProvider, BuildContext context) async {
    if (!doctorProvider.validateForm()) {
      setState(() {
        _isLoading = false;
      });
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all the details.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    setState(() {
      _isLoading = true;
    });
    // update doctor information to database
    await doctorProvider.updateDoctorInfo();
    setState(() {
      _isLoading = false;
    });
    Navigator.pushNamedAndRemoveUntil(
        context, '/confirmation_screen', (route) => false);
  }
}
