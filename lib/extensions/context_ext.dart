import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/localization/app_localizations.dart';


const TRANSITION_DURATION = 300;

extension ContextStringProvider on BuildContext {

  String getString(String key) => AppLocalizations.of(this).translate(key) ?? key;

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


  TextStyle get headline1 => Theme.of(this).textTheme.headline1;
  TextStyle get headline2 => Theme.of(this).textTheme.headline2;
  TextStyle get headline3 => Theme.of(this).textTheme.headline3;
  TextStyle get headline4 => Theme.of(this).textTheme.headline4;
  TextStyle get headline5 => Theme.of(this).textTheme.headline5;
  TextStyle get headline6 => Theme.of(this).textTheme.headline6;

  TextStyle get body1 => Theme.of(this).textTheme.bodyText1;
  TextStyle get body2 => Theme.of(this).textTheme.bodyText2;

  Color get primaryColor => Theme.of(this).primaryColor;
  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;
  Color get iconButtonColor => Theme.of(this).primaryColor;
  Color get dialogBackground => Theme.of(this).dialogBackgroundColor;
  Color get audioPlayerBackground => Theme.of(this).bottomNavigationBarTheme.backgroundColor;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;

}