import 'package:covid_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBox extends StatelessWidget {
  // Hint text for text field
  final String hintText;

  // Callback functions
  final Function(String) onChanged;
  final Function(String) onSaved;

  // Other properties
  final TextInputType keyboardType;
  final double height;
  final TextEditingController controller;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final Function onTap;
  final String initialText;
  final bool readOnly;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;

  // Constructor of text field
  const TextBox({
    this.onSaved,
    this.onTap,
    this.prefixIcon,
    this.textCapitalization,
    this.maxLines,
    this.controller,
    this.height,
    this.readOnly,
    this.suffixIcon,
    this.initialText,
    this.inputFormatters,
    this.onChanged,
    this.hintText,
    this.keyboardType,
    this.autofocus,
    this.obscureText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      padding: EdgeInsets.only(
        top: 8.0,
        left: 16.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.4,
        ),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        style: textFieldInputStyle(context),
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        obscureText: obscureText ?? false,
        autofocus: autofocus ?? false,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        initialValue: initialText,
        onTap: onTap,
        inputFormatters: inputFormatters ?? [],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: textFieldHintStyle(context),
          contentPadding: EdgeInsets.only(bottom: 12.0),
        ),
        onChanged: (value) => onChanged(value),
        onSaved: (value) => onSaved(value),
      ),
    );
  }
}
