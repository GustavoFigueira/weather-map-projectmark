// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'views/home_view.dart';

void main() {
  // Initialize the bindings before running the app.
  InitialBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather Challenge',
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
