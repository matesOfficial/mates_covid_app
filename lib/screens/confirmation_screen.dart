import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
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
            "Thank you for sharing these details with us",
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
              Navigator.pushNamedAndRemoveUntil(
                  context, "/wrapper", (route) => false);
            },
            child: Text("Return to home screen"),
          ),
        ),
        SizedBox(height: 32)
      ],
    ));
  }
}
