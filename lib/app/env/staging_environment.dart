import 'dart:ui';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:weather_map/app/config/firebase/firebase_options_staging.dart';
import 'package:weather_map/app/config/flavors.dart';

class StagingAppEnvironment implements MainAppEnvironment {
  @override
  String get name => 'staging';

  @override
  Flavor get flavor => Flavor.staging;

  @override
  Color get flavorBannerColor => const Color(0xFFA56E16);

  @override
  FirebaseOptions get firebaseOptions =>
      DefaultFirebaseOptionsStaging.currentPlatform;

  @override
  Uri get baseUrl => Uri.parse('');

  @override
  String get openWeatherMapApiKey => '40d58b699617eae28c8141f423de413a';

  @override
  String get assetsUrl =>
      '';
}
