import 'package:weather_map/app.dart';
import 'package:weather_map/app/env/production_environment.dart';

Future<void> main() async => mainApp(environment: ProductionAppEnvironment());
