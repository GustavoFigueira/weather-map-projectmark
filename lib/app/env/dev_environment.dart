import 'dart:ui';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:weather_map/app/config/firebase/firebase_options_dev.dart';
import 'package:weather_map/app/config/flavors.dart';

class DevAppEnvironment implements MainAppEnvironment {
  @override
  String get name => 'dev';

  @override
  Flavor get flavor => Flavor.dev;

  @override
  Color get flavorBannerColor => const Color(0xFF16396F);

  @override
  FirebaseOptions get firebaseOptions =>
      DefaultFirebaseOptionsDev.currentPlatform;

  @override
  Uri get baseUrl =>
      Uri.parse('https://api.openweathermap.org/data/2.5');

  @override
  String get openWeatherMapApiKey => '40d58b699617eae28c8141f423de413a';

  @override
  String get assetsUrl => '';
}
