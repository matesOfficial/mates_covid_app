import 'package:covid_app/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloodDropLogo extends StatelessWidget {
  // Can either be BLOOD or PLASMA
  final String dropType;

  BloodDropLogo({Key key, this.dropType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          ImageConstants.BLOOD_DROP_IMAGE_URL,
          color: dropType == "BLOOD" ? Color(0xffEF5350) : Color(0xffFFBD00),
        ),
        Positioned(
          top: 28,
          left: 12,
          right: 12,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}
