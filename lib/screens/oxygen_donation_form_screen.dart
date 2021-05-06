import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/confirmation_screen.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// TODO: Make the code for this page a bit cleaner

class OxygenDonationFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text Theme
    TextTheme textTheme = Theme.of(context).textTheme;
    // user profile provider
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context);
    // user model provider
    final UserModel user = Provider.of<UserModel>(context, listen: false);
    // Text editing controllers
    TextEditingController _oxygenUtiilityController = TextEditingController();
    TextEditingController _collegeController = TextEditingController();
    // Set text for controllers
    _oxygenUtiilityController.text =
        userProfileProvider.userProfile.bloodGroup ?? "";
    _collegeController.text = userProfileProvider.userProfile.collegeName ?? "";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Image.asset(
                    ImageConstants.oxygen_cylinder,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Oxygen Donor",
                    style: textTheme.headline6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: TextBox(
                  hintText: "What do you want to donate?",
                  keyboardType: TextInputType.name,
                  controller: _oxygenUtiilityController,
                  readOnly: true,
                  onTap: () => _showBloodGroupDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 32, 32, 16),
                child: TextBox(
                  hintText: "Name",
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => userProfileProvider.updateName(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextBox(
                  hintText: "Pin Code",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChanged: (value) =>
                      userProfileProvider.updatePinCode(value),
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
                  onTap: () => _showSelectCityDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextBox(
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  initialText: user.phoneNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) =>
                      userProfileProvider.updatePhoneNumber(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: TextBox(
                  hintText: "Blood Group",
                  keyboardType: TextInputType.name,
                  controller: _oxygenUtiilityController,
                  readOnly: true,
                  onTap: () => _showBloodGroupDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextBox(
                  hintText: "MATES Affiliation",
                  readOnly: true,
                  controller: _collegeController,
                  onTap: () => _showSelectCollegeDialog(context),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: BottomButton(
                  loadingState: userProfileProvider.isUpdatingUserProfile,
                  disabledState: false,
                  child: Text("Continue"),
                  onPressed: () =>
                      _onSubmitDetails(userProfileProvider, context),
                ),
              ),
              SizedBox(height: 32)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBloodGroupDialog(BuildContext context) {
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your blood group",
        children: AppConstants.BLOOD_GROUP_LIST
            .map(
              (e) => MultiSelectDialogItem(
            text: e,
            onPressed: () {
              userProfileProvider.updateBloodGroup(e);
              Navigator.pop(context);
            },
          ),
        ).toList(),
      ),
    );
  }

  Future<void> _showSelectCollegeDialog(BuildContext context) {
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your college name",
        children: AppConstants.COLLEGES_LIST
            .map(
              (e) => MultiSelectDialogItem(
            text: e,
            onPressed: () {
              userProfileProvider.updateCollegeName(e);
              Navigator.pop(context);
            },
          ),
        ).toList(),
      ),
    );
  }

  Future<void> _showSelectCityDialog(BuildContext context) {
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => MultiSelectDialog(
        title: "Select your city name",
        children: AppConstants.CITIES_LIST
            .map(
              (e) => MultiSelectDialogItem(
            text: e,
            onPressed: () {
              userProfileProvider.updateCityName(e);
              Navigator.pop(context);
            },
          ),
        ).toList(),
      ),
    );
  }



  Future<void> _onSubmitDetails(
      UserProfileProvider userProfileProvider, BuildContext context) async {
    if (!userProfileProvider.validateBloodDonationForm()) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all the details.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    final UserModel user = Provider.of<UserModel>(context, listen: false);
    await userProfileProvider.updateUserProfile(user.uid);
    userProfileProvider.resetProvider();
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(),
      ),
    );
  }
}