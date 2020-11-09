import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/localization/app_localizations.dart';

extension ContextStringProvider on BuildContext {

  String getString(String key) => AppLocalizations.of(this).translate(key) ?? key;

}