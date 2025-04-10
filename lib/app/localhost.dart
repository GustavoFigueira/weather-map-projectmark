import 'package:weather_map/app.dart';
import 'package:weather_map/app/env/localhost_environment.dart';

Future<void> main() async => mainApp(environment: LocalhostAppEnvironment());
