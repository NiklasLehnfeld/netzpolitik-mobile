import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_blog_app_template/utils/url_launcher.dart';

class WPHtml extends StatelessWidget {

  final String data;

  const WPHtml(this.data);

  @override
  Widget build(BuildContext context) {
    return Html(
        data: data,
        onLinkTap: openUrl,
    );
  }

  void openUrl(String url) => UrlLauncher.launch(url);

}