import 'package:battery_alarm/screens/home_screen.dart';
import 'package:battery_alarm/screens/tap_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case "tapNotification":
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TapScreen(response: args['response']),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  } 
}
