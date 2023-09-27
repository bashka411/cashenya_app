import 'screens/history/ui/history_page.dart';
import '/screens/home/ui/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home-page':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/history-page':
        return MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        );
      default:
        return null;
    }
  }
}
