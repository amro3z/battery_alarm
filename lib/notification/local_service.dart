import 'dart:async';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalService {
  static FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse>
      notificationStreamController = StreamController<NotificationResponse>();
  static onTap(NotificationResponse response) {
    notificationStreamController.add(response);
    debugPrint("Notification clicked with payload: ${response.payload}");
  }

  static Future<void> initNotification() async {
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

  static  showBasicNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('sound'),
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    try{
    await flutterLocalNotification.show(
      0,
      "🔋 Battery Alert",
      "Your battery state is being monitored (Basic)",
      platformChannelSpecifics,
      payload: "Basic Notification Payload",
    );
    return Future.value(true);
    }
    catch (e) {
      log("Error showing basic notification: $e");
      return Future.value(false);
    }
  }

  static Future<bool> showRepeatedNotification() async {
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
    try{
    await flutterLocalNotification.periodicallyShow(
      1,
      "🔋 Battery Alert",
      "Your battery state is being monitored (Repeated)",
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: "Repeated Notification Payload",
    );
     log("Repeated notification");
    return Future.value(true);
    } catch (e) {
      log("Error showing repeated notification: $e");
      return Future.value(false);
    }
  }

  static void showScheduledNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id_scheduled',
      'your_channel_name_scheduled',
      channelDescription: 'your_channel_description_scheduled',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    log(tz.TZDateTime.now(tz.local).toString());
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    await flutterLocalNotification.zonedSchedule(
      2,
      "🔋 Battery Alert",
      "Your battery state is being monitored (Scheduled)",
      tz.TZDateTime(tz.local, 2025, 7, 30, 23, 19,),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: "Scheduled Notification Payload",
    );
  }

  static Future<void> cancelNotifications({required int id}) async {
    await flutterLocalNotification.cancel(id);
  }
}
