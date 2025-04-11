import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class DayHourWeatherModel {
  final DateTime dateTime;
  final int currentHour;
  final double temperature;
  final String? weather;

  DayHourWeatherModel({
    required this.dateTime,
    required this.currentHour,
    required this.temperature,
    this.weather,
  });

  WeatherCondition get condition {
    switch (weather) {
      case 'Clear':
        return WeatherCondition.sunny;
      case 'Clouds':
        return WeatherCondition.cloudy;
      case 'Rain':
        return WeatherCondition.rainy;
      default:
        return WeatherCondition.clear;
    }
  }

  factory DayHourWeatherModel.fromJson(Map<String, dynamic> json) =>
      DayHourWeatherModel(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        currentHour:
            DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).hour,
        temperature: (json['main']['temp'] as num).toDouble(),
        weather:
            json['weather'] != null
                ? (json['weather'] as List).isNotEmpty
                    ? (json['weather'][0]['main'] as String)
                    : null
                : null,
      );
}
