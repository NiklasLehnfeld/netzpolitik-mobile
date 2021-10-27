import 'package:netzpolitik_mobile/tasks/notification-task.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case NotificationTask.NAME:
        return NotificationTask().run();
    }
    return Future.value(true);
  });
}

extension WorkManagerExt on Workmanager {
  void initTasks() async {
    var workmanager = Workmanager();
    await workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    await workmanager.registerPeriodicTask(
        NotificationTask.NAME, NotificationTask.NAME,

        frequency: Duration(minutes: 15));
  }
}
