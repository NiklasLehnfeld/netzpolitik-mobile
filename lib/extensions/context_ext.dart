import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/localization/app_localizations.dart';


const TRANSITION_DURATION = 300;

extension ContextExteinsions on BuildContext {

  String getString(String key) => AppLocalizations.of(this)?.translate(key) ?? key;

  void navigate(Widget Function(BuildContext) builder, {bool isDialog = false}) => Navigator.of(this).push(
      PageRouteBuilder(
        fullscreenDialog: isDialog,
        opaque: !isDialog,
        barrierDismissible: isDialog,
        barrierColor: primaryColor.withOpacity(0.5),
        pageBuilder: (context, __, _) => builder(context),
        transitionDuration: Duration(milliseconds: TRANSITION_DURATION),
        reverseTransitionDuration: Duration(milliseconds: TRANSITION_DURATION),
      ),
  );

  void showBottomSheet({required Widget Function(BuildContext) builder}) => showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: builder,
    context: this,
  );

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;


  TextStyle get headline1 => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headline2 => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headline3 => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get headline4 => Theme.of(this).textTheme.titleLarge!;
  TextStyle get headline5 => Theme.of(this).textTheme.titleMedium!;
  TextStyle get headline6 => Theme.of(this).textTheme.titleSmall!;

  TextStyle get body1 => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get body2 => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get quote => Theme.of(this).textTheme.bodySmall!.copyWith(
    fontStyle: FontStyle.italic
  );

  TextStyle get caption => Theme.of(this).textTheme.displaySmall!;

  Color get primaryColor => Theme.of(this).primaryColor;
  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;
  Color get iconButtonColor => Theme.of(this).primaryColor;
  Color get dialogBackground => Theme.of(this).dialogBackgroundColor;
  Color get audioPlayerBackground => Theme.of(this).scaffoldBackgroundColor;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get density => MediaQuery.of(this).devicePixelRatio;
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  bool get isWide => width > 700;
  bool get isUltraWide => width > 1100;

}