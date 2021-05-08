import 'package:covid_app/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFooter extends StatelessWidget {
  final String screenType;

  AppFooter({this.screenType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        this.screenType == "SPLASH_SCREEN"
            ? Container()
            : Center(
                child: Text(
                  "Initiative By",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            this.screenType == "SPLASH_SCREEN"
                ? Container()
                : SvgPicture.asset(
                    ImageConstants.LOGO_3_IMAGE_URL,
                    fit: BoxFit.contain,
                  ),
            this.screenType == "SPLASH_SCREEN" ? Container() : Spacer(),
            SvgPicture.asset(
              ImageConstants.LOGO_IMAGE_URL,
              height: 49,
              fit: BoxFit.contain,
            ),
            Spacer(),
            SvgPicture.asset(
              ImageConstants.LOGO_1_IMAGE_URL,
              fit: BoxFit.contain,
            ),
            Spacer(),
            SvgPicture.asset(
              ImageConstants.LOGO_2_IMAGE_URL,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
