import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/home_screen.dart';
import 'package:covid_app/widgets/blood_drop_logo.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlasmaDonationFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text Theme
    TextTheme textTheme = Theme.of(context).textTheme;
    // user profile provider
    final UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);
    // user model provider
    final UserModel user = Provider.of<UserModel>(context, listen: false);

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
                    dropType: "PLASMA",
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Plasma Donor",
                    style: textTheme.headline6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextBox(
                  hintText: "Name",
                  textCapitalization: TextCapitalization.words,
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
                      userProfileProvider.updatePinCode(int.parse(value)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: TextBox(
                  hintText: "City",
                  keyboardType: TextInputType.name,
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
                  readOnly: true,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextBox(
                  hintText: "MATES Affiliation",
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                  hintText: "Date of COVID positive report",
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  suffixIcon: Icon(Icons.date_range),
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

  Future<void> _onSubmitDetails(
      UserProfileProvider userProfileProvider, BuildContext context) async {
    if (userProfileProvider.userProfile.name == null ||
        userProfileProvider.userProfile.email == null ||
        userProfileProvider.userProfile.gender == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all the details.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    final UserModel user = Provider.of<UserModel>(context, listen: false);
    await userProfileProvider.updateUserProfile(user.uid);
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
