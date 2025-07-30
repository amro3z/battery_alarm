import 'package:battery_alarm/notification/local_service.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var battery = Battery();
  late BatteryState batterState = BatteryState.discharging;

  @override
  void initState() {
    super.initState();
    battery.batteryState.then((value) {
      setState(() {
        batterState = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your Battery Status is: $batterState'),
            ListTile(
              title: Text("Basic Notification"),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Trigger the basic notification
                // Assuming LocalService is properly initialized
                LocalService.showBasicNotification();
              },
              trailing: IconButton(
                icon: Icon(Icons.cancel_outlined),
                color: Colors.red,
                onPressed: () {
                  LocalService.cancelNotifications(id: 0);
                },
              ),
            ),
            ListTile(
              title: Text("Repeated Notification"),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Trigger the repeated notification
                // Assuming LocalService is properly initialized
                LocalService.showRepeatedNotification();
              },
              trailing: IconButton(
                icon: Icon(Icons.cancel_outlined),
                color: Colors.red,
                onPressed: () {
                  LocalService.cancelNotifications(id: 1);
                },
              ),
            ),
             ListTile(
              title: Text("Scheduled Notification"),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Trigger the scheduled notification
                // Assuming LocalService is properly initialized
                LocalService.showScheduledNotification();
              },
              trailing: IconButton(
                icon: Icon(Icons.cancel_outlined),
                color: Colors.red,
                onPressed: () {
                  LocalService.cancelNotifications(id: 2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
