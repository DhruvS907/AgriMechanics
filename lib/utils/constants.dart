import 'package:flutter/material.dart';

const Color kprimaryColor = Color(0xff2eb560);
const Color kprimaryTextColor = Colors.white;
// Light Theme Color Palette
const Color kLightSecondaryColor = Color(0xff0c793d);
const Color kLightPrimaryBackgroundColor = Color(0xffFFFFFF);
const Color kLightSecondaryBackgroundColor = Color(0xffF9F9F9);
const Color kLightPrimaryTextColor = Color(0xff444444);
const Color kLightSecondaryTextColor = Color.fromARGB(255, 211, 211, 211);
const Color kLightPrimaryDisabledTextColor = Color(0xffACACAB);
ThemeData kLightThemeData = ThemeData(
  highlightColor: kLightSecondaryColor,
  useMaterial3: true,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: kprimaryColor),
  ),
  iconTheme: const IconThemeData(
    color: kLightPrimaryTextColor,
  ),
  fontFamily: 'poppins',
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(kprimaryTextColor),
    fillColor: MaterialStateProperty.all(kLightPrimaryBackgroundColor),
  ),
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    titleMedium: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    titleLarge: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    bodySmall: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    bodyMedium: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    bodyLarge: TextStyle(color: kLightPrimaryTextColor, letterSpacing: 0.15),
    displaySmall: TextStyle(
      fontSize: 16,
      color: kLightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayLarge: TextStyle(
      fontSize: 28,
      color: kLightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    displayMedium: TextStyle(
      fontSize: 23,
      color: kLightPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: kprimaryColor,
  ),
  primaryColor: kprimaryColor,
  scaffoldBackgroundColor: kLightPrimaryBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kLightPrimaryBackgroundColor,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kLightSecondaryColor,
    background: kLightPrimaryBackgroundColor,
    onPrimaryContainer: kLightSecondaryBackgroundColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: kLightPrimaryTextColor.withOpacity(0.5)),
    labelStyle: const TextStyle(color: kLightPrimaryTextColor),
    focusColor: kLightPrimaryTextColor,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kprimaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kprimaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kprimaryColor,
    selectionColor: kprimaryColor,
    selectionHandleColor: kLightSecondaryColor,
  ),
  sliderTheme: SliderThemeData(
    thumbColor: kprimaryColor,
    activeTrackColor: kprimaryColor,
    inactiveTrackColor: kLightPrimaryTextColor.withOpacity(0.3),
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(BorderSide(color: kprimaryColor)),
    ),
  ),
);
