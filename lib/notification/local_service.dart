import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalService {
  FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification response
        debugPrint("User clicked notification → payload: ${response.payload}");
      },
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse response) {
            // Handle background notification response
            debugPrint(
              "Background notification clicked → payload: ${response.payload}",
            );
          },
    );
  }

  showBasicNotification() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    flutterLocalNotification.show(0, "title", "body", platformChannelSpecifics);
  }
}
