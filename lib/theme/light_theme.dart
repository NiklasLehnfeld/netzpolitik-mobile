import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

var baseTextStyle = TextStyle();

ThemeData lightTheme(BuildContext context, double fontSize) => ThemeData(
    primarySwatch: Colors.blue,
    hintColor: Colors.grey,
    scaffoldBackgroundColor: Colors.grey[100],
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: baseTextStyle.copyWith(
          fontSize: fontSize + 6,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headlineMedium: baseTextStyle.copyWith(
          fontSize: fontSize + 5,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headlineSmall: baseTextStyle.copyWith(
          fontSize: fontSize + 4,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      titleLarge: baseTextStyle.copyWith(
          fontSize: fontSize + 3,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      titleMedium: baseTextStyle.copyWith(
          fontSize: fontSize + 2,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      titleSmall: baseTextStyle.copyWith(
          fontSize: fontSize + 1,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      bodyLarge: baseTextStyle.copyWith(fontSize: fontSize),
      bodyMedium: baseTextStyle.copyWith(fontSize: fontSize - 3),
    ));
