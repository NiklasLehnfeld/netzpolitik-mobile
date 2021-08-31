import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _FONT_SIZE_DEFAULT = 17;
const MAX_FONT_SIZE = 21.0;
const MIN_FONT_SIZE = 14.0;

class AppSettings extends ChangeNotifier {

  SharedPreferences _sharedPreferences;
  List<MapEntry<String, Function>> fonts;

  AppSettings() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
    fonts = GoogleFonts.asMap().entries.toList();
  }

  int get fontSize => _sharedPreferences?.getInt('fontSize') ?? _FONT_SIZE_DEFAULT;

  set fontSize(int size) {
    _sharedPreferences.setInt('fontSize', size);
    notifyListeners();
  }

  String get fontType => _sharedPreferences?.getString('fontType');

  set fontType(String type) {
    _sharedPreferences.setString('fontType', type);
    notifyListeners();
  }



}