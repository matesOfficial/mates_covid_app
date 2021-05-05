import 'dart:async';

import 'package:covid_app/constants/image_constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
/// Navigate to new route after 3 seconds
  Future<void> push() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  // TODO: Add animation while moving to next page

  route() {
    Navigator.pushReplacementNamed(context, '/wrapper');
  }

  @override
  void initState() {
    push();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // text theme
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.LOGO_IMAGE_URL,
              width: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),
            Text(
              "Mates Warriors",
              style: textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
