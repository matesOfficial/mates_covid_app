import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  final String displayImageUrl;
  DisplayPicture({this.displayImageUrl});
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(displayImageUrl),
        ),
        Positioned(
          bottom: 0,
          right: -8,
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.add_a_photo_outlined,
                  color: Colors.black, size: 20)),
        ),
      ],
    );
  }
}
