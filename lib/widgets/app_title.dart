import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Text Theme
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      "COVID Resources and Helpline",
      style: textTheme.headline5,
    );
  }
}