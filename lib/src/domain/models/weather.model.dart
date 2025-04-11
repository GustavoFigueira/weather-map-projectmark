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

  @HiveField(3)
  final double? feelsLike;

  @HiveField(4)
  final double tempMin;

  @HiveField(5)
  final double tempMax;

  @HiveField(7)
  final double? windSpeed;

  @HiveField(8)
  final int? clouds;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    this.windSpeed,
    this.clouds,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    temperature: (json['main']['temp'] as num).toDouble(),
    humidity: json['main']['humidity'] as int,
    pressure: json['main']['pressure'] as int,
    feelsLike:
        json['main']['feels_like'] != null
            ? (json['main']['feels_like'] as num).toDouble()
            : null,
    tempMin: (json['main']['temp_min'] as num).toDouble(),
    tempMax: (json['main']['temp_max'] as num).toDouble(),
    windSpeed:
        json['wind']?['speed'] != null
            ? (json['wind']['speed'] as num).toDouble()
            : null,
    clouds: json['clouds']?['all'] as int?,
  );
}
