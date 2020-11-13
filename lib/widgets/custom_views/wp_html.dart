import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_blog_app_template/utils/url_launcher.dart';

class WPHtml extends StatelessWidget {
  final String data;
  final TextStyle style;

  const WPHtml(this.data, {this.style});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      onLinkTap: openUrl,
      defaultTextStyle: style,
    );
  }

  void openUrl(String url) => UrlLauncher.launch(url);
}
