import 'dart:developer';
import 'package:battery_alarm/notification/local_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManager {
  static final Workmanager _instance = Workmanager(); 
  @pragma('vm:entry-point')
  static void callbackDispatcher() async {
    _instance.executeTask((task, inputData) async {
      switch (task) {
        case 'Basic Notification':
          return await LocalService.showBasicNotification();
        case 'Repeated Notification':
          return await LocalService.showRepeatedNotification();
        default:
          log('Unknown task: $task');
          return Future.value(false);
      }
    });
  }

  static Future<void> init() async {
    try {
      log("Starting Workmanager initialization");
      await _instance.initialize(callbackDispatcher);
      log("Workmanager initialized successfully");
      await registerTask(id: "1", name: "Basic Notification");
      await registerTask(id: "2", name: "Repeated Notification"); // أضف هذا
    } catch (e) {
      log("Error during initialization or task registration: $e");
    }
  }

  static Future<void> registerTask({
    required String id,
    required String name,
  }) async {
    try {
      await _instance.registerOneOffTask(id, name);
      log("Task registered with id: $id and name: $name");
    } catch (e) {
      log("Error registering task: $e");
    }
  }

  static void cancelTask({required String taskId}) {
    _instance.cancelByUniqueName(taskId);
    log("Task cancelled");
  }
}
