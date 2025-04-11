import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class MainAppEnvironment {
  /// Environment name.
  String get name;

  /// Flavor of the app.
  Flavor get flavor;

  /// Color for the flavor banner.
  Color get flavorBannerColor;

  /// Firebase configurations.
  FirebaseOptions get firebaseOptions;

  /// Base service url.
  Uri get baseUrl;

  /// The OpenWeatherMap API key.
  /// [Disclaimer:] This key should be kept secret and injected at build time.
  /// This is only for demonstration purposes.
  String get openWeatherMapApiKey;

  /// The URL to the assets files (images, etc), from a CND like AWS S3 bucket.
  /// This is a good practice to avoid having the assets in the app bundle and
  /// to be able to update them without having to update the app and decrease
  /// the app size.
  String get assetsUrl;
}

enum Flavor { prod, staging, dev, localhost }

class FlavorManager {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'Weather Map';
      case Flavor.staging:
        return 'Weather Map staging';
      case Flavor.dev:
        return 'Weather Map dev';
      case Flavor.localhost:
        return 'Weather Map localhost';
      default:
        return 'Weather Map';
    }
  }

  static Widget debugBanner({
    required Widget child,
    required MainAppEnvironment environment,
    bool show = false,
  }) =>
      show
          ? Banner(
            location: BannerLocation.topEnd,
            message: environment.name,
            color: environment.flavorBannerColor,
            textStyle: const TextStyle(
              fontSize: 12.0,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
          : child;
}
