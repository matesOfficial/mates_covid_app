import 'package:covid_app/constants/image_constants.dart';
//import 'package:covid_app/constants/url_constants.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/screens/consultation/doctor_registration_form.dart';

class ConsultancyBridge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                child: Text("Are you a doctor?"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorRegistrationScreen(),
                    ),
                  );
                },
                loadingState: false,
                disabledState: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: BottomButton(
                  child: Text("Are you a Pharmacist / Chemist ?"),
                  onPressed: () {
                    return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorRegistrationScreen(),
                      ),
                    );
                  },
                  loadingState: false,
                  disabledState: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
