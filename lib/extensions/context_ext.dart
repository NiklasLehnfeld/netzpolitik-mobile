import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/localization/app_localizations.dart';

extension ContextStringProvider on BuildContext {

  String getString(String key) => AppLocalizations.of(this).translate(key) ?? key;

  TextStyle get headline1 => Theme.of(this).textTheme.headline1;
  TextStyle get headline2 => Theme.of(this).textTheme.headline2;
  TextStyle get headline3 => Theme.of(this).textTheme.headline3;
  TextStyle get headline4 => Theme.of(this).textTheme.headline4;
  TextStyle get headline5 => Theme.of(this).textTheme.headline5;
  TextStyle get headline6 => Theme.of(this).textTheme.headline6;

  TextStyle get body1 => Theme.of(this).textTheme.bodyText1;
  TextStyle get body2 => Theme.of(this).textTheme.bodyText2;

  Color get primaryColor => Theme.of(this).primaryColor;

}