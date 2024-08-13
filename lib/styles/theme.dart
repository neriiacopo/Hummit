import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark, // Specify dark mode
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Set the brightness to dark
      ).copyWith(
        // secondary: Colors.amber, // Secondary color
        surface: Colors.grey[900], // Surface color for dark theme
        onPrimary: Colors.white, // Text color on primary color
        onSecondary: Colors.black, // Text color on secondary color
        onSurface: Colors.white, // Text color on surfaces
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        // Lyrics settings
        headlineLarge: GoogleFonts.rubikMonoOne(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }
}
