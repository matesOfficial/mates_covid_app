import 'package:covid_app/constants/app_constants.dart';
import 'package:covid_app/global.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/confirmation_screen.dart';
import 'package:covid_app/screens/otp_screen.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/utils/date_formatter.dart';
import 'package:covid_app/widgets/blood_drop_logo.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/multi_select_dialog.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// TODO: Make the code for this page a bit cleaner

class BloodDonationFormScreen extends StatefulWidget {
  @override
  _BloodDonationFormScreenState createState() => _BloodDonationFormScreenState();
}

class _BloodDonationFormScreenState extends State<BloodDonationFormScreen> {
  // loading state variable
  bool _isLoading = false;
  // Text editing controllers
  TextEditingController _cityController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Text Theme
    TextTheme textTheme = Theme.of(context).textTheme;
    // user profile provider
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context);
    // user model provider
    final UserModel user = Provider.of<UserModel>(context, listen: false);
    // Set text for controllers
    _cityController.text = userProfileProvider.userProfile.city ?? "";
    _bloodGroupController.text =
        userProfileProvider.userProfile.bloodGroup ?? "";
    _collegeController.text = userProfileProvider.userProfile.collegeName ?? "";
    _dateController.text = DateFormatter.formatDate(
        userProfileProvider.userProfile.lastBloodDonationTimestamp) ??
        "";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: BloodDropLogo(
                    dropType: "BLOOD",
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Blood Donor",
                    style: textTheme.headline6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 16),
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
                  controller: _cityController,
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
                  controller: _bloodGroupController,
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
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 32,
                  right: 32,
                  bottom: 32,
                ),
                child: TextBox(
                  hintText: "Date of last blood donation",
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  controller: _dateController,
                  onTap: () => _selectDate(context),
                  suffixIcon: Icon(
                    Icons.date_range,
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

  Future<void> _selectDate(BuildContext context) async {
    final UserProfileProvider userProfileProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      userProfileProvider.getLastBloodDonationDate(picked);
    }
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
    setState(() {
      _isLoading = true;
    });

    /// OTP verification method
    return AuthService.signInWithPhone(
      "${userProfileProvider.userProfile.phoneNumber
      }",

      /// Callbacks
      onAutoPhoneVerificationCompleted: (AuthCredential credential) {},

      /// Fired when auto phone verification gets failed
      onPhoneVerificationFailed: (FirebaseAuthException e) {
        logger.w(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AuthService.getMessageFromErrorCode(e.code)),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      },

      /// Fired when the code is sent from server
      onPhoneCodeSent: (String verificationId, [int forceCodeResend]) async {
        // turn off the loading state of button upon successful login
        setState(() {
          _isLoading = false;
        });
        // Go to OTP screen to input the OTP and verify if entered OTP was correct
        bool _isOtpValid = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              verificationId: verificationId,
              fromDonorScreen: true,
            ),
          ),
        );
        logger..d(_isOtpValid);
        //  If entered OTP is valid
        if (_isOtpValid == true) {
          Navigator.pushNamedAndRemoveUntil(context, '/confirmation_screen' , (route) => false);
        }
        // Display error message in case of invalid OTP.
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("The entered OTP is invalid."),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
    );
  }
  }
