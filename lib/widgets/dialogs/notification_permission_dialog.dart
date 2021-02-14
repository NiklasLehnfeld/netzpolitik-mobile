import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/rest/push_notifications.dart';
import 'package:provider/provider.dart';


class NotificationPermissionDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title(context),
      content: content(context),
      actions: [
        cancelButton(context),
        acceptButton(context),
      ],
    );
  }

  Widget title(BuildContext context) => Text(
    context.getString('notification_title'),
    style: context.headline3,
  );

  Widget content(BuildContext context) => Text(
    context.getString('notification_content'),
    style: context.body1,
  );

  Widget acceptButton(BuildContext context) => FlatButton(
  child: Text(context.getString('notification_yes')),
  onPressed: () async {
    var pushNotificationManager = context.read<PushNotificationsManager>();
    await pushNotificationManager.requestPermission();
    Navigator.of(context).pop();
   },
  );

  Widget cancelButton(BuildContext context) => FlatButton(
    child: Text(context.getString('notification_no')),
    onPressed: () => Navigator.of(context).pop(),
  );

}