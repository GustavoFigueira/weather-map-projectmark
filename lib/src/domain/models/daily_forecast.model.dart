import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class DailyForecastModel {
  final DateTime date;
  final double minTemperature;
  final double maxTemperature;
  final String? weather;

  DailyForecastModel({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
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

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      DailyForecastModel(
        date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        minTemperature: (json['main']['temp_min'] as num).toDouble(),
        maxTemperature: (json['main']['temp_max'] as num).toDouble(),
        weather:
            json['weather'] != null
                ? (json['weather'] as List).isNotEmpty
                    ? (json['weather'][0]['main'] as String)
                    : null
                : null,
      );
}
