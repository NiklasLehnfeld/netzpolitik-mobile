import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

var baseTextStyle = TextStyle();

ThemeData lightTheme(BuildContext context, double fontSize) =>
    ThemeData(
      primarySwatch: Colors.blue,
      hintColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey[100],
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: baseTextStyle.copyWith(
            fontSize: fontSize + 6, fontWeight: FontWeight.bold),
        displayMedium: baseTextStyle.copyWith(
            fontSize: fontSize + 5, fontWeight: FontWeight.bold),
        displaySmall: baseTextStyle.copyWith(
            fontSize: fontSize + 4, fontWeight: FontWeight.bold),
        headlineLarge: baseTextStyle.copyWith(
            fontSize: fontSize + 3, fontWeight: FontWeight.bold),
        headlineMedium: baseTextStyle.copyWith(
            fontSize: fontSize + 2, fontWeight: FontWeight.bold),
        headlineSmall: baseTextStyle.copyWith(
            fontSize: fontSize + 1, fontWeight: FontWeight.bold),
        bodyLarge: baseTextStyle.copyWith(fontSize: fontSize),
        bodyMedium: baseTextStyle.copyWith(fontSize: fontSize - 2),
        bodySmall: baseTextStyle.copyWith(fontSize: fontSize - 4),
      ),
    );

