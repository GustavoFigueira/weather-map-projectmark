import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

/// Initialize Hive local database with web compatibility.
Future<void> initHive() async {
  await Hive.initFlutter();
  Hive..registerAdapter(CityModelAdapter())
  ..registerAdapter(WeatherModelAdapter());
}
