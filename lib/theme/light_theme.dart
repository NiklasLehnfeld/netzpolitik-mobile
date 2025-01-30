import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

var baseTextStyle = TextStyle();

ThemeData lightTheme(BuildContext context, double fontSize) =>
    ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.white,
        primaryContainer: Colors.blue.shade700,
        onPrimaryContainer: Colors.white70,

        secondary: Colors.blueAccent,
        onSecondary: Colors.white,
        secondaryContainer: Colors.blueAccent.shade700,
        onSecondaryContainer: Colors.white70,

        tertiary: Colors.cyan,
        onTertiary: Colors.white,
        tertiaryContainer: Colors.cyan.shade700,
        onTertiaryContainer: Colors.white70,

        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.red.shade700,
        onErrorContainer: Colors.white70,

        background: Colors.white,
        onBackground: Colors.black87,

        surface: Colors.grey.shade100,
        onSurface: Colors.black87,

        surfaceVariant: Colors.grey.shade300,
        onSurfaceVariant: Colors.black54,

        outline: Colors.grey.shade600,
        shadow: Colors.black,
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: Colors.blue.shade200,
        surfaceTint: Colors.blue,

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Text color
        ),
      ),
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

