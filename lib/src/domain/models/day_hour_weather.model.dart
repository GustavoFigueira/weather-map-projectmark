import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class DayHourWeatherModel {
  final int currentHour;
  final double temperature;
  final WeatherCondition condition;

  DayHourWeatherModel({
    required this.currentHour,
    required this.temperature,
    required this.condition,
  });
}
