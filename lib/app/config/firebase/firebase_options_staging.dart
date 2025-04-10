// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptionsStaging {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDI6kuawz8ldfb4W5JY2llIkISC7_9HosQ',
    appId: '1:926425028744:web:9d4e9541b2c1ccd3daa73d',
    messagingSenderId: '926425028744',
    projectId: 'weather-map-projectmark',
    authDomain: 'weather-map-projectmark.firebaseapp.com',
    storageBucket: 'weather-map-projectmark.firebasestorage.app',
    measurementId: 'G-PLKSEN7H56',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlu9gX3GB8cIlAN4Nj13Itc3WOVi7Qx9w',
    appId: '1:926425028744:android:87382e8316f71b86daa73d',
    messagingSenderId: '926425028744',
    projectId: 'weather-map-projectmark',
    storageBucket: 'weather-map-projectmark.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrG_5VDi92c4ljBz8brPrIUGZiFjlVAEc',
    appId: '1:926425028744:ios:80eeca2ea2ff55a0daa73d',
    messagingSenderId: '926425028744',
    projectId: 'weather-map-projectmark',
    storageBucket: 'weather-map-projectmark.firebasestorage.app',
    iosBundleId: 'com.projectmark.weatherMap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrG_5VDi92c4ljBz8brPrIUGZiFjlVAEc',
    appId: '1:926425028744:ios:80eeca2ea2ff55a0daa73d',
    messagingSenderId: '926425028744',
    projectId: 'weather-map-projectmark',
    storageBucket: 'weather-map-projectmark.firebasestorage.app',
    iosBundleId: 'com.projectmark.weatherMap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDI6kuawz8ldfb4W5JY2llIkISC7_9HosQ',
    appId: '1:926425028744:web:0d9205626abfa080daa73d',
    messagingSenderId: '926425028744',
    projectId: 'weather-map-projectmark',
    authDomain: 'weather-map-projectmark.firebaseapp.com',
    storageBucket: 'weather-map-projectmark.firebasestorage.app',
    measurementId: 'G-FYF82XQF2B',
  );
}
