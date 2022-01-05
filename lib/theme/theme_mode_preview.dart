import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/height.dart';

class ThemeModePreviewState {
  final ThemeMode value;
  final Widget preview;
  final String text;

  const ThemeModePreviewState({
    required this.value,
    required this.preview,
    required this.text,
  });
}

class ThemeModePreview extends StatelessWidget {

  final ThemeModePreviewState state;
  final void Function()? onTap;
  final bool? selected;

  const ThemeModePreview({
    required this.state,
    this.onTap,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 9 / 16,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    border: selected == true ? Border.all(color: borderColor(context), width: 2) : null,
                ),
                margin: selected == true ? EdgeInsets.zero : EdgeInsets.all(4.0),
                child: state.preview,
              ),
            ),
          ),
          Height(4),
          Flexible(child: Text(state.text, style: context.caption, textAlign: TextAlign.center,))
        ],
      ),
    );
  }

  Color borderColor(BuildContext context) {
    return context.isDarkTheme ? Colors.white : Colors.black;
  }
}
