import 'package:weather_map/app.dart';
import 'package:weather_map/app/env/dev_environment.dart';

Future<void> main() async => mainApp(environment: DevAppEnvironment());
