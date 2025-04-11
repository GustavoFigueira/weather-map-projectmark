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
  Uri get baseUrl =>
      Uri.parse('https://api.openweathermap.org/data/2.5');

  @override
  String get openWeatherMapApiKey => 'ed825be7b608515bc2a65d9b3f4b8299';

  @override
  String get assetsUrl => '';
}
