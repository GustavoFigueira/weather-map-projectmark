import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';

class FetchCityWeatherUseCase {
  final WeatherRepository weatherRepository;

  FetchCityWeatherUseCase(this.weatherRepository);

  Future<Map<CityModel, WeatherModel?>> call(List<CityModel> cities) async {
    final weatherBox = await Hive.openBox<WeatherModel>('weather');
    final weatherData = <CityModel, WeatherModel?>{};

    for (final city in cities) {
      final cachedWeather = weatherBox.get(city.id);

      if (cachedWeather != null) {
        weatherData[city] = cachedWeather;
      } else {
        final freshWeather = await weatherRepository.fetchWeatherFromServer(
          lat: city.lat,
          lon: city.long,
          unit: Get.find<GlobalManager>().temperatureUnit.value,
        );

        if (freshWeather != null) {
          weatherData[city] = freshWeather;
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
