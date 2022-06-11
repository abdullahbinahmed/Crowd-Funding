import 'package:flutter/material.dart';

final ThemeData crowdFundingAppTheme = _buildTheme();

ThemeData _buildTheme() {
  const Color customMagenta50 = Color.fromARGB(255, 97, 69, 163);
  const Color customMagenta100 = Color(0xfffaac9d);
  const Color customMagenta300 = Color(0xfff8836c);
  const Color customMagenta400 = Color(0xfff65a3b);

  const Color customMagenta900 = Color(0xfff4310a);
  const Color customMagenta600 = Color(0xffc32708);

  const Color customErrorRed = Color(0xFFC5032B);

  const Color customSurfaceWhite = Color(0xFFFFFBFA);
  const Color customBackgroundWhite = Colors.white;

  const ColorScheme _customColorScheme = ColorScheme(
    primary: customMagenta50,
    primaryVariant: customMagenta600,
    secondary: Colors.amber,
    secondaryVariant: customMagenta400,
    surface: Colors.purpleAccent,
    background: customSurfaceWhite,
    error: customMagenta900,
    onPrimary: Colors.red,
    onSecondary: Colors.deepOrange,
    onSurface: customMagenta300,
    onBackground: customMagenta100,
    onError: Colors.redAccent,
    brightness: Brightness.light,
  );

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Color.fromARGB(255, 198, 0, 229),
    bottomAppBarColor: Color.fromARGB(255, 126, 0, 164),
    primaryColorLight: Color.fromARGB(255, 104, 21, 192),
    buttonTheme: ButtonThemeData(
        height: 40.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textTheme: ButtonTextTheme.primary,
        buttonColor: Color.fromARGB(255, 126, 0, 164),
        colorScheme: _customColorScheme),
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
