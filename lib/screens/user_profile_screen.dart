import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/widgets/profile_info_tile.dart';
import 'package:covid_app/widgets/display_picture.dart';
import 'package:covid_app/theme/style.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final UserProfileProvider userProfileProvider = Provider.of<UserProfileProvider>(context);
    // TODO Change font-sizes in style.dart
    // Header starts here.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: appBarTitleStyle(context),
        ),
      ),
      // Body starts here.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  DisplayPicture(),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userProfileProvider.userProfileStream.name == null ? Container() :
                      Text(
                        userProfileProvider.userProfile.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        userProfileProvider.userProfileStream.phoneNumber,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Change Number   >",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 12),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              ProfileInfoTile(
                title: "View donor history",
                isClickable: true,
              ),
              ProfileInfoTile(
                title: "Log Out",
                isClickable: true,
                onPressed: () => AuthService.logOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
