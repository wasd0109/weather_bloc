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
            bodyColor: Colors.grey[700],
            displayColor: Colors.black,
          ),
      iconTheme: IconThemeData(color: Colors.black),
      primaryColor: Colors.white,
      cardColor: Colors.grey[100],
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey,
      accentColor: Colors.grey[600],
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintStyle: TextStyle(color: Colors.black),
      ),
      brightness: Brightness.light,
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return getLightTheme(context).copyWith(
      primaryColor: Colors.grey[900],
      accentColor: Colors.white,
      cardColor: Color(0xFF303030),
      iconTheme: IconThemeData(color: Colors.white),
      inputDecorationTheme:
          getLightTheme(context).inputDecorationTheme.copyWith(
                fillColor: Colors.white24,
                filled: true,
                hintStyle: TextStyle(color: Colors.white70),
              ),
      backgroundColor: Colors.grey,
      textTheme: getLightTheme(context)
          .textTheme
          .apply(displayColor: Colors.white, bodyColor: Colors.white70),
      brightness: Brightness.dark,
    );
  }
}
