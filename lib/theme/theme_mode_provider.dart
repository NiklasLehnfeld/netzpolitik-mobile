import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const THEME_MODE_KEY = 'THEME_MODE_KEY';
const DEFAULT_THEME_MODE = ThemeMode.system;

class ThemeModeProvider extends ChangeNotifier{
  SharedPreferences? _sharedPreferences;

  ThemeModeProvider() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  set themeMode(ThemeMode? themeMode) {
    _sharedPreferences?.setInt(THEME_MODE_KEY, themeMode?.index ?? DEFAULT_THEME_MODE.index);
    notifyListeners();
  }

  ThemeMode get themeMode {
    var themeModeIndex = _sharedPreferences?.getInt(THEME_MODE_KEY);
    if (themeModeIndex == null) {
      return DEFAULT_THEME_MODE;
    }

    return ThemeMode.values[themeModeIndex];
  }

  bool get isLightTheme => themeMode == ThemeMode.light;

  bool get shouldShowThemeDialog => _sharedPreferences?.getInt(THEME_MODE_KEY) == null;

  void save() {
    themeMode = themeMode;
  }
}

extension ThemeModeContextExt on BuildContext {

  ThemeMode get themeMode {
    var themeModeProvider = watch<ThemeModeProvider>();
    return themeModeProvider.themeMode;
  }

}
