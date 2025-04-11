import 'dart:async';
import 'dart:ui';

import 'package:catcher_2/catcher_2.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/core/bindings/initial_binding.dart';
import 'package:weather_map/src/core/constants/locale.constants.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/core/routing/routes.dart';
import 'package:weather_map/src/core/services/hive/hive.init.dart';
import 'package:weather_map/src/core/services/navigation/navigation_service.dart';
import 'package:weather_map/src/core/services/services.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';

const defaultTranslationsPath = 'assets/translations';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => EasyLocalization(
    path: defaultTranslationsPath,
    supportedLocales: kSupportedLocales,
    fallbackLocale: kDefaultLocale,
    startLocale: kDefaultLocale,
    useOnlyLangCode: true,
    child: GetMaterialApp.router(
      title: 'Mobile Challenge (ProjectMark)',
      debugShowCheckedModeBanner: false,
      // Enables click and drag with the mouse on scrollable widgets.
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
    ),
  );
}

void _runApp({required MainAppEnvironment environment}) => runApp(MainApp());

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

      // Set the current environment for the app.
      GlobalManager().updateEnvironment(environment);

      // Initialize the default locale.
      initializeDateFormatting(GlobalManager().currentLocale);

      // Initialize Hive serivce.
      await initHive();

      // Init services of the app .
      initServices(environment);

      // Initialize the bindings before running the app.
      InitialBinding().dependencies();

      if (kDebugMode) {
        _runApp(environment: environment);
      } else {
        final debugOptions = Catcher2Options(DialogReportMode(), [
          ConsoleHandler(),
        ]);
        final releaseOptions = Catcher2Options(DialogReportMode(), [
          EmailManualHandler(['me@guslopes.dev']),
        ]);

        Catcher2(
          runAppFunction: () => _runApp(environment: environment),
          navigatorKey: NavigationService.rootNavigatorKey,
          debugConfig: debugOptions,
          releaseConfig: releaseOptions,
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
