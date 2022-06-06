import 'package:flutter/material.dart';

final ThemeData crowdFundingAppTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Color.fromARGB(255, 198, 0, 229),
    bottomAppBarColor: Color.fromARGB(255, 126, 0, 164),
    primaryColorLight: Color.fromARGB(255, 104, 21, 192),
    buttonTheme: ButtonThemeData(
      height: 40.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      textTheme: ButtonTextTheme.primary,
    ),
    primaryColor: Color.fromARGB(255, 101, 0, 164),
    accentIconTheme: IconThemeData(color: Colors.white),
    textTheme: base.textTheme.copyWith(
      overline: TextStyle(fontSize: 10.0, color: Colors.grey),
      button: TextStyle(color: Color.fromARGB(255, 194, 33, 243)),
    ),
    hintColor: Color.fromARGB(255, 228, 111, 15),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
      fillColor: Color.fromARGB(170, 255, 255, 255),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Color.fromARGB(255, 112, 0, 164)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      filled: true,
      helperStyle: new TextStyle(color: Colors.green),
    ),
  );
}
