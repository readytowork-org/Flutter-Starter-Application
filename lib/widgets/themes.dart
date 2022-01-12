import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData lightThemeValue() {
    return ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
        // primaryTextTheme: GoogleFonts.latoTextTheme()
        appBarTheme: const AppBarTheme(
            // color: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 25)));
  }

  static ThemeData darkThemeValue() {
    return ThemeData(
        // primarySwatch: Colors.white,
        fontFamily: GoogleFonts.lato().fontFamily,
        brightness: Brightness.dark,
        // primaryTextTheme: GoogleFonts.latoTextTheme()
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 25)));
  }
}
