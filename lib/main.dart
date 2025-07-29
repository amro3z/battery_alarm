import 'package:battery_alarm/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Initial());
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
