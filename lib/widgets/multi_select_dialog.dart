import 'package:flutter/material.dart';

class MultiSelectDialog extends StatelessWidget {
  final String title;
  final List<MultiSelectDialogItem> children;
  MultiSelectDialog({this.title  , this.children});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: children,
    );
  }
}

class MultiSelectDialogItem extends StatelessWidget {
  const MultiSelectDialogItem(
      {Key key,  this.text, this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
          Expanded(
            child: Divider(),
          )
        ],
      ),
    );
  }
}
