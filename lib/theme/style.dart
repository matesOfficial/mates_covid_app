import 'package:flutter/material.dart';

class ThemeUtils {
  static final ThemeData defaultAppThemeData = appTheme();

  static ThemeData appTheme() {
    Color primaryColor = Color(0xffFAB550);

    return ThemeData(
      // Colors
      primaryColor: primaryColor,
      accentColor: Color(0xffFAF0E1),
      hintColor: Color(0xFF999999),
      // Widget theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          onPrimary: Color(0xffFFFFFF),
          onSurface: Color(0xff707070), // Disabled button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 5.0,
        unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: StadiumBorder(),
        disabledColor: Color(0xFFE5E3DC),
        height: 50,
      ),
      cardColor: Color(0xFFFDFBEF),
      cardTheme: CardTheme(elevation: 5),
      // canvasColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        opacity: 1.0,
      ),
      // Text themes
      textTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        headline6: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        subtitle2: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        button: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}

// Additional text themes
TextStyle appBarTitleStyle(BuildContext context) =>
    Theme.of(context).textTheme.headline6.copyWith(
          color: Color(0xff233561),
          fontFamily: "SF UI Display",
          fontWeight: FontWeight.normal,
        );

TextStyle textFieldLabelStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
          color: Theme.of(context).accentColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );

TextStyle textFieldHintStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.normal,
        );

TextStyle textFieldInputStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        );

TextStyle loginButtonTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.button.copyWith(color: Colors.black);

TextStyle textFieldSuffixStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

TextStyle boldCaptionStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold);
