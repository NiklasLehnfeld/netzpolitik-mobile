import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/logic/rating_manager.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_preview.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_preview_switcher.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_provider.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/height.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/splitted.dart';
import 'package:provider/provider.dart';

class ThemeModeDialog {
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => ThemeModeDialog().build(context),
      );

  void _dismiss(BuildContext context) {
    context.read<ThemeModeProvider>().save();
    Navigator.of(context).pop();
  }

  AlertDialog build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 125, horizontal: 10),
      title: Center(child: Text(context.getString('theme_mode_dialog_title'))),
      content: Column(
        children: [
          Text(context.getString('theme_mode_dialog_content_1')),
          Height(8),
          Text(context.getString('theme_mode_dialog_content_2')),
          Height(16),
          ThemeModePreviewSwitcher(states: [
            ThemeModePreviewState(
                value: ThemeMode.light,
                preview: Image.asset('assets/theme_mode_light.png', fit: BoxFit.cover),
                text: context.getString('thememode_light'),
            ),
            ThemeModePreviewState(
                value: ThemeMode.system,
                preview: Splitted(
                  first: Image.asset('assets/theme_mode_light.png', fit: BoxFit.cover),
                  second: Image.asset('assets/theme_mode_dark.png', fit: BoxFit.cover),
                ),
                text: context.getString('thememode_auto'),
            ),
            ThemeModePreviewState(
                value: ThemeMode.dark,
                preview: Image.asset('assets/theme_mode_dark.png', fit: BoxFit.cover),
                text: context.getString('thememode_dark'),
            ),
          ],),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.read<RatingManager>().openStore();
              _dismiss(context);
            },
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(context.primaryColor)),
            child: Text(context.getString('store_button'))),
        TextButton(
          onPressed: () {
            _dismiss(context);
          },
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all(context.primaryColor)),
          child: Text(context.getString('done')),
        )
      ],
    );
  }
}
