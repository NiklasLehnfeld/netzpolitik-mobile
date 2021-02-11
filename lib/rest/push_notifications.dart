import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<bool> requestPermission() => Platform.isIOS ? _firebaseMessaging.requestNotificationPermissions() : Future.value(true);

  void initialize() => _firebaseMessaging.configure();

}