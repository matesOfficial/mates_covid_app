import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  final String displayImageUrl;

  DisplayPicture({this.displayImageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: displayImageUrl != null
          ? null
          : Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.white,
            ),
      backgroundImage:
          displayImageUrl == null ? null : AssetImage(displayImageUrl),
    );
  }
}
