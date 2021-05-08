import 'package:covid_app/constants/image_constants.dart';
import 'package:covid_app/global.dart';
import 'package:covid_app/screens/otp_screen.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/services/navigation_service.dart';
import 'package:covid_app/widgets/app_footer.dart';
import 'package:covid_app/widgets/bottom_button.dart';
import 'package:covid_app/widgets/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Private variable for storing phone number
  String _phoneNumber;

  // Loading state variable
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 72.0, bottom: 32),
                child: SvgPicture.asset(ImageConstants.LOGIN_SCREEN_IMAGE_URL),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: TextBox(
                hintText: "+91 Phone Number",
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: BottomButton(
                child: Text(
                  "Get OTP",
                ),
                onPressed: () => _onPhoneSignIn(_phoneNumber, context),
                loadingState: _isLoading,
                disabledState: false,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: AppFooter(),
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  /// Phone Sign-In method
  Future<void> _onPhoneSignIn(String phoneNumber, BuildContext context) async {
    // Set bottom button to loading state until SMS is sent
    setState(() {
      _isLoading = true;
    });
    // Check if the entered phone number is correct
    if (phoneNumber == null || phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid phone number.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    /// OTP verification method
    return AuthService.signInWithPhone(
      "+91$phoneNumber",

      /// Callbacks

      /// Fired upon completion of phone code auto-retrieval
      onAutoPhoneVerificationCompleted: (PhoneAuthCredential credential) async {
        // TODO: Fix auto verification issue
        // try {
        //   await FirebaseAuth.instance.signInWithCredential(credential);
        // } on FirebaseAuthException catch (e) {
        //   return ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(AuthService.getMessageFromErrorCode(e.code)),
        //       backgroundColor: Theme.of(context).errorColor,
        //     ),
        //   );
        // } catch (e) {
        //   // throw e;
        //   return ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text("Something went wrong.Please try again later."),
        //       backgroundColor: Theme.of(context).errorColor,
        //     ),
        //   );
        // }
        // GetIt.instance<NavigationService>().pop();
      },

      /// Fired when auto phone verification gets failed
      onPhoneVerificationFailed: (FirebaseAuthException e) {
        // turn off the loading state of button upon successful login
        setState(() {
          _isLoading = false;
        });
        logger.w(e.message);
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AuthService.getMessageFromErrorCode(e.code)),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      },

      /// Fired when the code is sent from server
      onPhoneCodeSent: (String verificationId, [int forceCodeResend]) async {
        // turn off the loading state of button upon successful login
        setState(() {
          _isLoading = false;
        });
        // Go to OTP screen to input the OTP and verify if entered OTP was correct
        String _errorMessage = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              verificationId: verificationId,
            ),
          ),
        );
        //  If entered OTP is valid
        if (_errorMessage == null) {
          Navigator.pushNamedAndRemoveUntil(context, "/wrapper", (route) => false);
        }
        // in case user has not entered OTP.
        else if (_errorMessage == "NOT_ENTERED") {
          return;
        }
        // Display error message in case of invalid OTP.
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_errorMessage),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
    );
  }
}
