import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_provider.dart';
import 'package:provider/provider.dart';

import 'custom_switch.dart';

class ThemeModeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeModeProvider>();

    return CustomSwitch<ThemeMode>(
      value: themeProvider.themeMode,
      onChanged: (ThemeMode themeMode) {
        themeProvider.themeMode = themeMode;
      },
      states: [
        CustomSwitchState(
          backgroundColor: Colors.blue[100]!,
          value: ThemeMode.light,
          icon: FontAwesomeIcons.solidSun,
          iconColor: Colors.black54,
          text: context.getString('thememode_light'),
        ),
        CustomSwitchState(
          backgroundColor: Colors.green[100]!,
          value: ThemeMode.system,
          icon: FontAwesomeIcons.font,
          iconColor: Colors.black38,
          text: context.getString('thememode_auto'),
        ),
        CustomSwitchState(
          backgroundColor: Colors.black,
          value: ThemeMode.dark,
          icon: FontAwesomeIcons.solidMoon,
          iconColor: Colors.white,
          text: context.getString('thememode_dark'),
        ),
      ],
    );
  }
}
