import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  final String checkBoxTitle;
  final bool checkBoxValue;
  final Function(bool) onChanged;
  MyCheckBox({this.checkBoxTitle, this.checkBoxValue , this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Theme.of(context).primaryColor, width: 0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              checkBoxTitle,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          Checkbox(
            value: checkBoxValue,
            onChanged: (value) => onChanged(value),
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
