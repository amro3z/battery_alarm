import 'package:battery_alarm/notification/local_service.dart';
import 'package:battery_alarm/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  await LocalService.initNotification();
  runApp(const Initial());
}

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Alarm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
