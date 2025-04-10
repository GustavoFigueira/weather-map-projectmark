import 'package:get/get.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/models/next_days_weather.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class HomeViewModel {
  final cities = <CityModel>[].obs;
  final weatherData = <int, WeatherModel?>{}.obs;
  final loadingCities = false.obs;
  final loadingWeather = false.obs;

  List<CityModel> get currentCities => cities;

  /// List of weather data for the next 7 days.
  final nextDaysWeather = List.generate(7, (index) {
    final dayOfWeek =
        (DateTime.now().add(Duration(days: 1)).weekday + index) % 7;
    return NextDaysWeatherModel(
      dayOfWeek: dayOfWeek,
      condition:
          WeatherCondition.values[index % WeatherCondition.values.length],
      minTemperature: 15.0 + index,
      maxTemperature: 25.0 + index,
    );
  });

  /// List of weather data for the next hours of the current day.
  final nextHoursWeather = List.generate(24, (index) {
    final currentHour = DateTime.now().hour;
    final hour = (currentHour + index) % 24;
    return DayHourWeatherModel(
      currentHour: hour,
      temperature: 15.0 + (index % 10),
      condition: WeatherCondition.values[index % WeatherCondition.values.length],
    );
  });
}
