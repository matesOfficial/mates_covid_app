import 'package:flutter/material.dart';
import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonorRecieverScreen extends StatelessWidget {
  const DonorRecieverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 72, 0, 72),
                child: SvgPicture.asset(
                    ImageConstants.DONOR_RECIEVER_SCREEN_IMAGE_URL),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: BottomButton(
                  child: Text(
                    "Looking For Donors",
                  ),
                  onPressed: () => null,
                  loadingState: false,
                  disabledState: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 32.0),
                child: BottomButton(
                  child: Text(
                    "Become A Donor",
                  ),
                  onPressed: () => null,
                  loadingState: false,
                  disabledState: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
