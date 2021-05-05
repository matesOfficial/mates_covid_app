import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/screens/dashboard_screen.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class DonorReceiverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              // Header
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 72.0,
                    bottom: 64,
                  ),
                  child: Image.asset(
                      ImageConstants.DONOR_RECEIVER_SCREEN_IMAGE_URL),
                ),
              ),
              BottomButton(
                child: Text("Looking for donors"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                        userType: "RECEIVER",
                      ),
                    ),
                  );
                },
                loadingState: false,
                disabledState: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: BottomButton(
                  child: Text("Become a donor"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          userType: "DONOR",
                        ),
                      ),
                    );
                  },
                  disabledState: false,
                  loadingState: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
