import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      )
          .copyWith(
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            bodyText1: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            headline1: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              letterSpacing: -0.5,
            ),
            headline2: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            headline3: TextStyle(
              fontSize: 60,
            ),
            headline4: TextStyle(
              fontSize: 25,
            ),
            subtitle1: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
            ),
            subtitle2: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          )
          .apply(
            bodyColor: Colors.grey[600],
            displayColor: Colors.black,
          ),
      iconTheme: IconThemeData(color: Colors.black),
      primaryColor: Colors.white,
      cardColor: Colors.grey[200],
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return getLightTheme(context).copyWith(
        primaryColor: Colors.grey[900],
        cardColor: Color(0xFF303030),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: getLightTheme(context)
            .textTheme
            .apply(displayColor: Colors.white, bodyColor: Colors.white70));
  }
}
