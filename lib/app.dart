import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/bindings/initial_binding.dart';
import 'package:weather_map/src/core/constants/locale.constants.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/core/services/navigation/navigation_service.dart';
import 'package:weather_map/src/core/services/services.dart';
import 'package:weather_map/src/views/home_view.dart';

const defaultTranslationsPath = 'assets/translations';

void _runApp({required MainAppEnvironment environment}) => runApp(
  EasyLocalization(
    path: defaultTranslationsPath,
    supportedLocales: supportedLocales,
    fallbackLocale: defaultLocale,
    child: GetMaterialApp(
      title: 'Mobile Challenge (ProjectMark)',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
    ),
  ),
);

Future<void> mainApp({required MainAppEnvironment environment}) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      // Remove the # symbol from the URL (web only).
      setPathUrlStrategy();

      // Make status bar translucent.
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );

      // Init services of the app .
      initServices(environment);

      // Initialize the bindings before running the app.
      InitialBinding().dependencies();

      if (kDebugMode) {
        _runApp(environment: environment);
      } else {
        Catcher2Options debugOptions = Catcher2Options(DialogReportMode(), [
          ConsoleHandler(),
        ]);
        Catcher2Options releaseOptions = Catcher2Options(DialogReportMode(), [
          EmailManualHandler(["recipient@email.com"]),
        ]);
        // Catcher2Options profileOptions = Catcher2Options(
        //   NotificationReportMode(), [ConsoleHandler(), ToastHandler()],
        //   handlerTimeout: 10000, customParameters: {"example"c: "example_parameter"},);

        Catcher2(
          runAppFunction: () => _runApp(environment: environment),
          navigatorKey: NavigationService.rootNavigatorKey,
          debugConfig: debugOptions,
          releaseConfig: releaseOptions,
          //profileConfig: profileOptions,
          // enableLogger: false,
        );
      }
    },
    (error, stack) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          context: ErrorDescription('runZonedGuarded - uncaught error'),
        ),
      );
    },
  );
}
