import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncher {

  static void launch(String url) async {
    assert( await launcher.canLaunch(url), 'Can not launch $url' );
    await launcher.launch(url);
  }

}