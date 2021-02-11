import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  PushNotificationsManager() {

    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure();

    _firebaseMessaging.getToken().then((token) =>
        print('FirebaseMessaging token: $token')
    );
  }

}