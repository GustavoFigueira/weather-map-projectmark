import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class FetchHourlyForecastUseCase {
  final WeatherRepository weatherRepository;

  FetchHourlyForecastUseCase(this.weatherRepository);

  Future<List<DayHourWeatherModel>?> call({
    required String lat,
    required String lon,
    TemperatureUnits? unit = TemperatureUnits.celsius,
    WeatherModel? currentWeather,
  }) async {
    final hourlyWeather = await weatherRepository.fetchHourlyForecastFromServer(
      lat: lat,
      lon: lon,
      unit: unit,
    );

    if (hourlyWeather == null) {
      return [];
    }

    final now = DateTime.now();

    final cityHourlyWeather =
        hourlyWeather
            .where((hourly) => hourly.dateTime.day == now.day)
            .toList();

    if (currentWeather != null) {
      cityHourlyWeather.insert(
        0,
        DayHourWeatherModel(
          dateTime: now,
          currentHour: now.hour,
          temperature: currentWeather.temperature,
          weather: currentWeather.weather,
        ),
      );
    }

    return cityHourlyWeather;
  }
}
