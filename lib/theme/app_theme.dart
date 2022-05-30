import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: const Color(0xff171c28),
    appBarTheme: const AppBarTheme(
      color: Color(0xff171c28),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(primary: Color(0xff171c28)),
    cardTheme: const CardTheme(color: Color(0xff171c28)),
    cardColor: const Color.fromARGB(255, 32, 43, 70),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(
        color: Colors.white,
      ),
      bodyText2: const TextStyle(
        color: Colors.white,
      ),
      headline1: const TextStyle(
        color: Colors.white,
      ),
      headline2: const TextStyle(
        color: Colors.white,
      ),
      headline3: const TextStyle(
        color: Colors.white,
      ),
      headline4: const TextStyle(
        color: Colors.white,
      ),
      headline5: const TextStyle(
        color: Colors.white,
      ),
      headline6: const TextStyle(
        color: Colors.white,
      ),
      subtitle1: const TextStyle(
        color: Colors.white,
      ),
      subtitle2: const TextStyle(
        color: Colors.white,
      ),
      button: const TextStyle(
        color: Colors.white,
      ),
      caption: const TextStyle(
        color: Colors.white,
      ),
      overline: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
