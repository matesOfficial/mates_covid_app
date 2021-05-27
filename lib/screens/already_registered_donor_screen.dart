import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class AlreadyRegisteredDonorScreen extends StatelessWidget {
  final String donorType;
  const AlreadyRegisteredDonorScreen({Key key , this.donorType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Image.asset(
              ImageConstants.CONFIRMATION_SCREEN_IMAGE_URL,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              donorType == "BLOOD" ?
              "You have already registered as a blood donor":
              "You have already registered as a plasma donor",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: BottomButton(
              loadingState: false,
              disabledState: false,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back"),
            ),
          ),
          SizedBox(height: 32)
        ],
      ),
    );
  }
}
