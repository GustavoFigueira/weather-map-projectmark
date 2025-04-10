import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/app/config/firebase/firebase.init.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/features/global/views/services_loading.view.dart';

/// Initialize services of the app including Firebase.
Future<void> initServices(MainAppEnvironment flavor) async {
  // Run the preload page while initializing the app.
  runApp(const ServicesLoadingView());

  // Initialize Firebase with the given flavor.
  // TODO: configure Firebase
  await initFirebase(flavor);

  // Initialize services of the app in parallel.
  await Future.wait([
    // Preloads fonts to avoid visual swapping.
    GoogleFonts.pendingFonts([
      GoogleFonts.archivo,
      GoogleFonts.archivoTextTheme,
    ]),
    // Initialize CodePush service (only for mobile).
    //ShorebirdCodePushService().checkForUpdates(),
    // Init DeepLink Listener
    //DeeplinkService().init(),
  ]);
}
