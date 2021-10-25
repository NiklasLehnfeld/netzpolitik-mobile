import 'package:netzpolitik_mobile/config/apps.dart';
import 'package:netzpolitik_mobile/logic/notification_manager.dart';
import 'package:netzpolitik_mobile/persistence/app_settings.dart';
import 'package:netzpolitik_mobile/rest/rest_client.dart';

class NotificationTask {

  static const String NAME = 'NotificationTask';

  // Unfortunately we cannot use BuildContext in a background task. Therefore we
  // cannot use the Providers stuff.
  void run() async {
    var restClient = RestClient(App.NETZPOLITIK.configuration.restConfiguration);
    var appSettings = AppSettings();
    var notificationManager = NotificationManager();

    var articles = await restClient.fetchArticles();
    var lastArticle = articles[0];

    if (appSettings.lastNotifiedArticle == null) {
      appSettings.lastNotifiedArticle = lastArticle.id;
      return Future.value(true);
    }

    if (appSettings.lastNotifiedArticle == lastArticle.id) {
      print('No new article');
      return Future.value(true);
    }

    appSettings.lastNotifiedArticle = lastArticle.id;
    notificationManager.showNotification(null, lastArticle);
    return Future.value(true);
  }

}