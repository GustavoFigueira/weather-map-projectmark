import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class NextDaysWeatherModel {
  final int dayOfWeek;
  final WeatherCondition condition;
  final double minTemperature;
  final double maxTemperature;

  NextDaysWeatherModel({
    required this.dayOfWeek,
    required this.condition,
    required this.minTemperature,
    required this.maxTemperature,
  });
}
