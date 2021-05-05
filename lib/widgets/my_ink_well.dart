import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyInkWell extends StatelessWidget {
  final String messageText;
  final String linkText;
  final Function onPressed;
  const MyInkWell({
    Key key,
    @required this.onPressed,
    @required this.messageText,
    @required this.linkText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Text Theme
    final TextTheme textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        style: textTheme.caption,
        children: [
          TextSpan(
            text: messageText,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          TextSpan(
            text: linkText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}
