// background_service.dart
import 'package:workmanager/workmanager.dart';
import 'package:battery_alarm/notification/local_service.dart';
import 'dart:developer' show log;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case 'Basic Notification':
          return await LocalService.showBasicNotification();
        case 'Repeated Notification':
          return await LocalService.showRepeatedNotification();
        default:
          log('Unknown task: $task');
          return Future.value(false);
      }
    } catch (e) {
      log("Error in callbackDispatcher: $e");
      return Future.value(false);
    }
  });
}