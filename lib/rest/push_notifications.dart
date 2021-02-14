import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

const DAILY_UPDATE_TOPIC = 'daily_updates';

class PushNotificationsManager {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<bool> requestPermission() => Platform.isIOS ? _firebaseMessaging.requestNotificationPermissions() : Future.value(true);

  void initialize() async {

    if (await Permission.notification.isGranted) {
      _firebaseMessaging.configure();
      await _firebaseMessaging.subscribeToTopic(DAILY_UPDATE_TOPIC);
    }
  }

  Future<bool> shouldAskForPermission() async => await Permission.notification.isUndetermined;



}