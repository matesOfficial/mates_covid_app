import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool isSelected;

  MyChip({Key key, this.onPressed, this.label, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text Theme
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: textTheme.caption.copyWith(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.7,
          ),
        ),
      ),
    );
  }
}
