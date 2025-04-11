import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class DailyForecastModel {
  final DateTime date;
  final double minTemperature;
  final double maxTemperature;
  final WeatherCondition condition;

  DailyForecastModel({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.condition,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) => DailyForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      minTemperature: (json['temp']['min'] as num).toDouble(),
      maxTemperature: (json['temp']['max'] as num).toDouble(),
      condition: WeatherCondition.values.firstWhere(
        (e) => e.toString().split('.').last == json['weather'][0]['main'].toLowerCase(),
        orElse: () => WeatherCondition.clear,
      ),
    );
}
