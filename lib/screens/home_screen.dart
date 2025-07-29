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
            
          ],
        ),
      ),
    );
  }
}
