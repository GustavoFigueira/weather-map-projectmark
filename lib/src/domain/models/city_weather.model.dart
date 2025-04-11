import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';

class CityWeatherModel {
  final CityModel city;
  final double temperature;

  final int humidity;
  final int pressure;
  final int? sunrise;
  final int? sunset;
  final int? timezone;

  final List<DayHourWeatherModel> hourlyTemperatures;
  final List<DailyForecastModel> dailyTemperatures;

  CityWeatherModel({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.hourlyTemperatures,
    required this.dailyTemperatures,
    this.sunrise,
    this.sunset,
    this.timezone,
  });
}
