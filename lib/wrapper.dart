import 'package:covid_app/global.dart';
import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/screens/home_screen.dart';
import 'package:covid_app/screens/loading_screen.dart';
import 'package:covid_app/screens/login_screen.dart';
import 'package:covid_app/screens/user_details_screen.dart';
import 'package:covid_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    if(user.uid == null){
      return LoginScreen();
    }
      logger.d(user.uid);
      return FutureBuilder<UserProfile>(
          future: FirestoreDatabaseService.getUser(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            UserProfile userProfile = snapshot.data;
            if (userProfile == null) {
              return UserDetailsScreen();
            }
            if (userProfile.name == null) {
              return UserDetailsScreen();
            }
            return HomeScreen();
          }
      );
  }
}
