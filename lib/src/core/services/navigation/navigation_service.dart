import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState>? rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldState> globalScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
