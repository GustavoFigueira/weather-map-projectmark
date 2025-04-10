import 'package:hive/hive.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class FetchWeatherUseCase {
  final WeatherRepository weatherRepository;

  FetchWeatherUseCase(this.weatherRepository);

  Future<Map<int, WeatherModel?>> call(List<CityModel> cities) async {
    final weatherBox = await Hive.openBox<WeatherModel>('weather');
    final weatherData = <int, WeatherModel?>{};

    for (final city in cities) {
      // Check if weather data is cached
      final cachedWeather = weatherBox.get(city.id);

      if (cachedWeather != null) {
        weatherData[city.id] = cachedWeather;
      } else {
        // Fetch fresh data from the server
        final freshWeather = await weatherRepository.fetchWeatherFromServer(
          lat: city.lat,
          lon: city.long,
        );

        if (freshWeather != null) {
          weatherData[city.id] = freshWeather;

          // Cache the fresh data
          weatherBox.put(city.id, freshWeather);
        }
      }
    }

    return weatherData;
  }

  Future<void> clearCache() async {
    final weatherBox = await Hive.openBox<WeatherModel>('weather');
    await weatherBox.clear();
  }
}
