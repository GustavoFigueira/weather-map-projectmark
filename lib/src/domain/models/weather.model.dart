import 'package:hive/hive.dart';

part 'weather.model.g.dart';

@HiveType(typeId: 1)
class WeatherModel extends HiveObject {
  @HiveField(0)
  final double temperature;

  @HiveField(1)
  final int humidity;

  @HiveField(2)
  final int pressure;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
    );
}
