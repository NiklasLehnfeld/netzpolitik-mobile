import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _FONT_SIZE_DEFAULT = 17;
const MAX_FONT_SIZE = 23.0;
const MIN_FONT_SIZE = 14.0;

class AppSettings extends ChangeNotifier {

  SharedPreferences _sharedPreferences;

  AppSettings() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  int get fontSize => _sharedPreferences?.getInt('fontSize') ?? _FONT_SIZE_DEFAULT;

  set fontSize(int size) {
    _sharedPreferences.setInt('fontSize', size);
    notifyListeners();
  }

}