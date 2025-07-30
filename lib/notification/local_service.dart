import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalService {
  static FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse response) {
    debugPrint("Notification clicked with payload: ${response.payload}");
  }

  static initNotification() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static void showBasicNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotification.show(
      0,
      "🔋 Battery Alert",
      "Your battery state is being monitored",
      platformChannelSpecifics,
    );
  }

  static void showRepeatedNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id_repeated',
      'your_channel_name_repeated',
      channelDescription: 'your_channel_description_repeated',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotification.periodicallyShow(
      1,
      "🔋 Battery Alert",
      "Your battery state is being monitored",
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
  static Future<void> cancelNotifications({required int id}) async {
    await flutterLocalNotification.cancel(id);
  }
}
