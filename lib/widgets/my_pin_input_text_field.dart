import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class MyPinInputTextField extends StatelessWidget {
  final Function(String) onChanged;

  MyPinInputTextField({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text Theme
    final TextTheme textTheme = Theme.of(context).textTheme;
    return PinInputTextField(
      pinLength: 6,
      decoration: BoxLooseDecoration(
        textStyle: textTheme.bodyText1,
        bgColorBuilder: PinListenColorBuilder(
          Theme.of(context).accentColor,
          Theme.of(context).accentColor,
        ),
        strokeColorBuilder: PinListenColorBuilder(
          Theme.of(context).dividerColor,
            Colors.black,
        ),
      ),
      textInputAction: TextInputAction.go,
      enabled: true,
      autoFocus: true,
      keyboardType: TextInputType.number,
      onChanged: (pin) => onChanged(pin),
      cursor: Cursor(
          enabled: true,
          color: Colors.black,
          width: 1.0
      ),
      enableInteractiveSelection: true,
    );
  }
}
