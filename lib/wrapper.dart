import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/screens/donor_receiver_screen.dart';
import 'package:covid_app/screens/home_screen.dart';
import 'package:covid_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    if(user.uid == null){
      return LoginScreen();
    }
    return HomeScreen();
  }
}
