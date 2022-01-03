import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_preview.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_provider.dart';
import 'package:provider/provider.dart';


class ThemeModePreviewSwitcher extends StatefulWidget {
  final List<ThemeModePreviewState> states;

  const ThemeModePreviewSwitcher({required this.states});

  @override
  State<ThemeModePreviewSwitcher> createState() =>
      _ThemeModePreviewSwitcherState();
}

class _ThemeModePreviewSwitcherState extends State<ThemeModePreviewSwitcher> {
  @override
  Widget build(BuildContext context) {
    var themeModeProvider = context.watch<ThemeModeProvider>();
    return Expanded(
      child: Row(
        children: widget.states.map((e) =>
            ThemeModePreview(
              state: e,
              onTap: () => themeModeProvider.themeMode = e.value,
              selected: themeModeProvider.themeMode == e.value,
            )
        ).toList(),
      ),
    );
  }
}
