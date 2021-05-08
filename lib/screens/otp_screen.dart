import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/global.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/widgets/app_footer.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/my_pin_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final bool fromDonorScreen;

  OtpScreen({@required this.verificationId, this.fromDonorScreen});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // private variable to store pin of entered OTP
  String _pin;

  // private variable to store loading state of button
  bool _loadingState = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, "NOT_ENTERED");
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              // Header
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: SvgPicture.asset(ImageConstants.OTP_SCREEN_IMAGE_URL),
                ),
              ),
              MyPinInputTextField(onChanged: (pin) {
                onEditingComplete(context, pin);
                _pin = pin;
              }),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: BottomButton(
                  child: Text("Verify and proceed"),
                  onPressed: () => onEditingComplete(context, _pin),
                  loadingState: _loadingState,
                  disabledState: false,
                ),
              ),
              Spacer(),
              AppFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onEditingComplete(BuildContext context, String pin) async {
    // Donor OTP verification
    if (widget.fromDonorScreen == true) {
      if (pin.length == 6) {
        setState(() {
          _loadingState = true;
        });
        final UserProfileProvider userProfileProvider =
            Provider.of<UserProfileProvider>(context, listen: false);
        String errorMessage = await AuthService.verifyOtpForDonors(
            widget.verificationId, pin, userProfileProvider.userProfile);
        logger.d("donor otp verification: $errorMessage");
        setState(() {
          _loadingState = false;
        });
        return Navigator.pop(context, errorMessage);
      }
    }
    // Normal OTP verification
    else {
      if (pin.length == 6) {
        setState(() {
          _loadingState = true;
        });
        String errorMessage =
            await AuthService.verifyOTP(widget.verificationId, pin);
        setState(() {
          _loadingState = false;
        });
        return Navigator.pop(context, errorMessage);
      }
    }
  }
}
