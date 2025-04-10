import 'dart:async';
import 'package:get/get.dart';
import '../models/city.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final cities = <City>[
    City(
      id: 1,
      label: 'Joinville - SC - Brazil',
      name: 'Joinville',
      state: 'SC',
      country: 'Brazil',
      countryShort: 'BR',
      lat: '-26.30444000',
      long: '-48.84556000',
    ),
    City(
      id: 2,
      label: 'San Francisco - CA - USA',
      name: 'San Francisco',
      state: 'CA',
      country: 'USA',
      countryShort: 'USA',
      lat: '37.77493000',
      long: '-122.41942000',
    ),
    City(
      id: 3,
      label: 'Urubici - SC - Brazil',
      name: 'Urubici',
      state: 'SC',
      country: 'Brazil',
      countryShort: 'BR',
      lat: '-28.0157',
      long: '-49.5925',
    ),
  ];

  // Map to store weather for each city (in memory cache)
  final weatherData = <int, Weather?>{}.obs;

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial data
    fetchWeatherForCities();
    // Setup timer to refresh data every 10 minutes.
    _refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchWeatherForCities();
    });
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  void fetchWeatherForCities() async {
    for (City city in cities) {
      final weather = await WeatherService.fetchWeather(
        lat: city.lat,
        lon: city.long,
      );
      // Cache the weather data based on the city's id.
      weatherData[city.id] = weather;
    }
    // Notify listeners that the weatherData map has been updated.
    weatherData.refresh();
  }
}
