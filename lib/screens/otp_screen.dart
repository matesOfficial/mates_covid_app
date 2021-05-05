import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/my_pin_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({@required this.verificationId});

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
    // Text Theme
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
            Spacer(),
            BottomButton(
              child: Text("Verify and proceed"),
              onPressed: () => onEditingComplete(context, _pin),
              loadingState: _loadingState,
              disabledState: false,
            ),
            SizedBox(height: 32),
            // TODO: Add MATES logo footer
          ],
        ),
      ),
    );
  }

  Future<void> onEditingComplete(BuildContext context, String pin) async {
    if (pin.length == 6) {
      setState(() {
        _loadingState = true;
      });
      bool _isValidOtp =
          await AuthService.verifyOTP(widget.verificationId, pin);
      setState(() {
        _loadingState = false;
      });
      return Navigator.pop(context, _isValidOtp);
    }
  }
}
