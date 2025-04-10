import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_map/src/presentation/home/home_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomeView(),
    ),
  ],
);
