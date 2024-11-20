import 'package:flutter/material.dart';

final baseTextStyle = TextStyle(
  color: Color(0xffe6e6e6),
);

ThemeData darkTheme(BuildContext context, double fontSize) {
  return ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xff2196f3),
      secondary: Color(0xff64ffda),
      surface: Color(0xff424242),
      background: Color(0xff616161),
      error: Color(0xffd32f2f),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: Color(0xff303030),
    canvasColor: Color(0xff303030),
    cardColor: Color(0xff424242),
    dividerColor: Colors.white.withOpacity(0.12),
    splashColor: Colors.white.withOpacity(0.25),
    highlightColor: Colors.white.withOpacity(0.25),
    dialogBackgroundColor: Color(0xff424242),
    // Add specific themes for toggleable widgets
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xff64ffda); // active color
        }
        return Colors.grey; // inactive color
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xff64ffda).withOpacity(0.5); // active track color
        }
        return Colors.grey.withOpacity(0.5); // inactive track color
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xff64ffda); // active color
        }
        return Colors.grey; // inactive color
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xff64ffda); // active color
        }
        return Colors.grey; // inactive color
      }),
    ),
    textTheme: TextTheme(
      displayLarge: baseTextStyle.copyWith(fontSize: fontSize + 6, fontWeight: FontWeight.bold),
      displayMedium: baseTextStyle.copyWith(fontSize: fontSize + 5, fontWeight: FontWeight.bold),
      displaySmall: baseTextStyle.copyWith(fontSize: fontSize + 4, fontWeight: FontWeight.bold),
      headlineLarge: baseTextStyle.copyWith(fontSize: fontSize + 3, fontWeight: FontWeight.bold),
      headlineMedium: baseTextStyle.copyWith(fontSize: fontSize + 2, fontWeight: FontWeight.bold),
      headlineSmall: baseTextStyle.copyWith(fontSize: fontSize + 1, fontWeight: FontWeight.bold),
      bodyLarge: baseTextStyle.copyWith(fontSize: fontSize),
      bodyMedium: baseTextStyle.copyWith(fontSize: fontSize - 2),
      bodySmall: baseTextStyle.copyWith(fontSize: fontSize - 4),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xff64ffda)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xffd32f2f)),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Text color
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      buttonColor: Color(0xff1e88e5),
      disabledColor: Colors.white.withOpacity(0.38),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.7),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white.withOpacity(0.12),
      deleteIconColor: Colors.white,
      disabledColor: Colors.white.withOpacity(0.1),
      selectedColor: Colors.white.withOpacity(0.3),
      secondarySelectedColor: Colors.white.withOpacity(0.15),
      labelStyle: TextStyle(color: Colors.white),
      secondaryLabelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      shape: StadiumBorder(),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xff64ffda),
      inactiveTrackColor: Colors.white.withOpacity(0.5),
      thumbColor: Color(0xff64ffda),
      overlayColor: Color(0xff64ffda).withOpacity(0.2),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: Color(0xff424242),
    ),
  );
}
