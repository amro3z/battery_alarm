import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalService {
  FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    InitializationSettings settings = InitializationSettings();
    await flutterLocalNotification.initialize(settings);
  }
}
