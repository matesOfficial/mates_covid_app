import 'package:flutter/material.dart';
import 'package:covid_app/widgets/profile_info_tile.dart';
import 'package:covid_app/widgets/display_picture.dart';
import 'package:covid_app/theme/style.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  DisplayPicture(
                    displayImageUrl: "assets/images/my_photo.jpg",
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Atishay Jain",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "+91 9497756473",
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
                title: "Adhaar Number",
                value: "38XXXXX234",
                isClickable: false,
              ),
              ProfileInfoTile(
                title: "Height",
                value: "183 cms",
                isClickable: true,
              ),
              ProfileInfoTile(
                title: "Weight",
                value: "62.5 Kgs",
                isClickable: true,
              ),
              ProfileInfoTile(
                title: "Health History",
                subHeading: "Diabties, Hyper Tension, Neurone Disease",
                isClickable: false,
              ),
              ProfileInfoTile(
                title: "Update Password",
                isClickable: true,
              ),
              ProfileInfoTile(
                title: "Log Out",
                isClickable: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
