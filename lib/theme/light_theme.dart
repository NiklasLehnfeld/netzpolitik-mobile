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
      headline1: baseTextStyle.copyWith(
          fontSize: fontSize + 6,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headline2: baseTextStyle.copyWith(
          fontSize: fontSize + 5,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headline3: baseTextStyle.copyWith(
          fontSize: fontSize + 4,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headline4: baseTextStyle.copyWith(
          fontSize: fontSize + 3,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headline5: baseTextStyle.copyWith(
          fontSize: fontSize + 2,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      headline6: baseTextStyle.copyWith(
          fontSize: fontSize + 1,
          color: context.primaryColor,
          fontWeight: FontWeight.bold),
      bodyText1: baseTextStyle.copyWith(fontSize: fontSize),
      bodyText2: baseTextStyle.copyWith(fontSize: fontSize - 3),
    ));
