import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:netzpolitik_mobile/utils/url_launcher.dart';

class WPHtml extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const WPHtml(this.data, {this.style});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          openUrl(url);
        }
      },
      //defaultTextStyle: style,
    );
  }

  void openUrl(String url) => UrlLauncher.launch(url);
}
