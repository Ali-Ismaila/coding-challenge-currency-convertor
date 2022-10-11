import 'package:flutter/material.dart';

import '../presentation/home/home.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/home': (BuildContext context) => const HomeScreen(),
  };
}
