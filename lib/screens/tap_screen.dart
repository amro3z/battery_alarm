import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TapScreen extends StatelessWidget {
  const TapScreen({super.key, required this.response});
  final NotificationResponse response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tap Screen")),
      body: Center(child: Text("${response.payload} was tapped + ${response.id} was the id of the notification + ${response.data} was the channel id")),
    );
  }
}
