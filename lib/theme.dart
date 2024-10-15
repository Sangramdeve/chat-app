import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cores/const/constants.dart'; // Your color constants

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: hPrimaryColor,
    scaffoldBackgroundColor: hBackgroundColor,
    appBarTheme: appBarTheme.copyWith(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: hSecondaryColor),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: hSecondaryColor,
      ),
    ),
    iconTheme: const IconThemeData(color: hSecondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: hPrimaryColor, // Button background
        textStyle: GoogleFonts.inter(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners for buttons
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: hPrimaryColor, // Text color
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: hSecondaryColor), // Default text color for light theme
    colorScheme: const ColorScheme.light(
      primary: hPrimaryColor,
      secondary: hBlueLight,
      background: neuLightBgColor, // Neu light background color
      surface: neuLightColor, // Neu light surface color
      error: kErrorColor,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: hPrimaryColor,
    scaffoldBackgroundColor: neuDarkBGColor, // Dark background color
    appBarTheme: appBarTheme.copyWith(
      backgroundColor: neuDarkBGColor,
      iconTheme: const IconThemeData(color: hColorLight),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: hColorLight, // Text color for dark theme
      ),
    ),
    iconTheme: const IconThemeData(color: hColorLight), // Icon color in dark mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: hPrimaryColor, // Button background
        textStyle: GoogleFonts.inter(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: hPrimaryColor,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: hColorLight), // Default text color for dark theme
    colorScheme: const ColorScheme.dark().copyWith(
      primary: hPrimaryColor,
      secondary: hBlueLight,
      background: neuDarkBGColor, // Neu dark background color
      surface: neuDarkColor, // Neu dark surface color
      error: kErrorColor,
    ),
  );
}

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
);
