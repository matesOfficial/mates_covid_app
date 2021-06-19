import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String subHeading;
  final Function onPressed;
  final String value;
  final bool isClickable;
  ProfileInfoTile({
    this.title,
    this.subHeading,
    this.value,
    this.isClickable,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    // TODO Change font-sizes in style.dart
    return InkWell(
      onTap: () => !isClickable ? null : onPressed(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                    subHeading == null
                        ? Container(height: 0)
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              subHeading,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14),
                            ),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    value == null
                        ? Container(height: 0)
                        : Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                          ),
                    !isClickable
                        ? Container(height: 0)
                        : Icon(Icons.chevron_right)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
