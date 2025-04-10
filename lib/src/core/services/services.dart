import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/app/config/firebase/firebase.init.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/core/services/hive/hive.init.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';
import 'package:weather_map/src/presentation/global/views/services_loading.view.dart';

/// Initialize services of the app including Firebase.
Future<void> initServices(MainAppEnvironment flavor) async {
  // Run the preload page while initializing the app.
  runApp(const ServicesLoadingView());

  // Set the current environment for the app.
  GlobalStateManager().updateEnvironment(flavor);

  // Initialize Firebase with the given flavor.
  await initFirebase(flavor);

  // Initialize services of the app in parallel.
  await Future.wait([
    // Initialize Hive serivce.
    initHive(),
    // Preloads fonts to avoid visual swapping.
    GoogleFonts.pendingFonts([
      GoogleFonts.archivo,
      GoogleFonts.archivoTextTheme,
    ]),
  ]);
}
