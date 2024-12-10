import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncher {

  static void launch(String url) async {
    await launcher.launchUrl(Uri.parse(url));
  }

}