import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/routes/article_detail_route.dart';

import '../providers.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  late final NotificationAppLaunchDetails? _appLaunchDetails;

  NotificationManager(BuildContext context)
      : _localNotificationsPlugin = FlutterLocalNotificationsPlugin() {

    _localNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((value) {
          _appLaunchDetails = value;
          if (_appLaunchDetails?.didNotificationLaunchApp ?? false) {
            _onNotificationTapped(context, _appLaunchDetails!.payload);
          }
        });

    final initializationSettings = InitializationSettings(
        android: _androidSettings(), iOS: _iosSettings());
    _localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) =>
            _onNotificationTapped(context, payload));
  }

  void showNotification(BuildContext context, Article article) {
    _localNotificationsPlugin.show(
        article.id ?? 0,
        article.subTitle,
        article.title,
        NotificationDetails(android: _articleChannel(context, article)),
        payload: jsonEncode(article.toJson()));
  }

  bool isOpenedByNotification() {
    return _appLaunchDetails != null && _appLaunchDetails!.didNotificationLaunchApp;
  }

  static void _onNotificationTapped(BuildContext context, String? payload) async {
    if (payload != null) {
      var article = Article.fromNotificationJson(jsonDecode(payload));

      Providers.navigatorKey.currentContext!.open((context) =>
          ArticleDetailRoute(article,
              isBig: false, identifier: 'notification'));
    }
  }

  static AndroidNotificationDetails _articleChannel(
          BuildContext context, Article article) =>
      AndroidNotificationDetails(
        'Articles',
        context.getString('article_notification_channel_name'),
        channelDescription:
            context.getString('article_notification_channel_description'),
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: article.title != null
            ? BigTextStyleInformation(
                article.title!,
              )
            : null,
      );

  static AndroidInitializationSettings _androidSettings() =>
      AndroidInitializationSettings('@drawable/app_icon');

  static IOSInitializationSettings _iosSettings() => IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      );
}
