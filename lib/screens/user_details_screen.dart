import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/confirmation.dart';
import 'package:covid_app/screens/home_screen.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/my_check_boc.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text Theme
    TextTheme textTheme = Theme.of(context).textTheme;
    // user profile provider
    final UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 72, left: 32),
              child: Text(
                "Create an account",
                style: textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextBox(
                hintText: "Full Name",
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => userProfileProvider.updateName(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextBox(
                hintText: "Email Address",
                onChanged: (value) => userProfileProvider.updateEmail(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  MyCheckBox(
                    checkBoxTitle: "Male",
                    checkBoxValue:
                        userProfileProvider.userProfile.gender == "MALE",
                    onChanged: (value) {
                      if (value == true) {
                        userProfileProvider.updateGender("MALE");
                      } else {
                        userProfileProvider.updateGender(null);
                      }
                    },
                  ),
                  SizedBox(width: 32),
                  MyCheckBox(
                    checkBoxTitle: "Female",
                    checkBoxValue:
                        userProfileProvider.userProfile.gender == "FEMALE",
                    onChanged: (value) {
                      if (value == true) {
                        userProfileProvider.updateGender("FEMALE");
                      } else {
                        userProfileProvider.updateGender(null);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: BottomButton(
                loadingState: userProfileProvider.isUpdatingUserProfile,
                disabledState: false,
                child: Text("Continue"),
                 onPressed: () => _onSubmitDetails(userProfileProvider, context),
              ),
            ),
          ],
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
