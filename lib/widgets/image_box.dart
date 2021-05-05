import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final Widget child;

  ImageBox({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: child,
    );
  }
}
