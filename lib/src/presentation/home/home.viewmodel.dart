import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/src/data/constants/default_cities.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/city_weather.model.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/models/next_days_weather.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';

class HomeViewModel extends GetxController {
  HomeViewModel(this.fetchWeatherUseCase);

  final FetchWeatherUseCase fetchWeatherUseCase;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _refreshTimer;

  final cities = <CityModel>[].obs;
  final weatherData = <int, WeatherModel?>{}.obs;
  final forecastData = <DailyForecastModel>[].obs;
  final loadingCities = false.obs;
  final loadingWeather = false.obs;
  final lastUpdated = Rxn<DateTime>();

  List<CityModel> get currentCities => cities;

  /// List of weather data for the next 7 days.
  final nextDaysWeather = List.generate(7, (index) {
    final dayOfWeek = (DateTime.now().weekday + index) % 7;
    return NextDaysWeatherModel(
      dayOfWeek: dayOfWeek,
      condition:
          WeatherCondition.values[index % WeatherCondition.values.length],
      minTemperature: 15.0 + index,
      maxTemperature: 25.0 + index,
    );
  });

  /// List of weather data for the next hours of the current day.
  final nextHoursWeather = List.generate(24 - DateTime.now().hour, (index) {
    final hour = DateTime.now().hour + index;
    return DayHourWeatherModel(
      currentHour: hour,
      temperature: 15.0 + (index % 10),
      condition:
          WeatherCondition.values[index % WeatherCondition.values.length],
    );
  });

  @override
  void onInit() {
    super.onInit();
    retrieveLastUpdated();
    initializeData();
    _setupAutoRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  Future<void> initializeData() async {
    GlobalManager().loading.value = true;
    try {
      Future.wait([fetchCities(), fetchWeatherForCities()]).then((_) {
        // Set the first city as the current city
        if (cities.isNotEmpty) {
          GlobalManager().updateCurrentCity(cities[0]);
        }
      });
    } catch (e) {
      Logger().e('Error initializing data: $e');
    } finally {
      GlobalManager().loading.value = false;
    }
  }

  void _setupAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchWeatherForCities();
    });
  }

  Future<void> retrieveLastUpdated() async {
    try {
      final box = await Hive.openBox<DateTime>('app_data');
      lastUpdated.value = box.get('lastUpdated');
    } catch (e) {
      Logger().e('Error retrieving last updated date: $e');
    }
  }

  Future<void> saveLastUpdated() async {
    try {
      final box = await Hive.openBox<DateTime>('app_data');
      lastUpdated.value = DateTime.now();
      await box.put('lastUpdated', lastUpdated.value!);
    } catch (e) {
      Logger().e('Error saving last updated date: $e');
    }
  }

  Future<void> fetchCities() async {
    try {
      loadingCities.value = true;

      // Open Hive box for cities
      final cityBox = await Hive.openBox<CityModel>('cities');

      // Load cached cities or use default cities
      if (cityBox.isNotEmpty) {
        cities.assignAll(cityBox.values.toList());
      } else {
        cities.assignAll(kDefaultAppCities);
        for (final city in cities) {
          cityBox.put(city.id, city);
        }
      }
    } catch (e) {
      Logger().e('Error fetching cities: $e');
    } finally {
      loadingCities.value = false;
    }
  }

  Future<void> fetchWeatherForCities() async {
    try {
      loadingWeather.value = true;
      final weatherDataMap = await fetchWeatherUseCase(cities);
      weatherData.assignAll(weatherDataMap);
      await saveLastUpdated();
    } catch (e) {
      Logger().e('Error fetching weather data: $e');
    } finally {
      loadingWeather.value = false;
    }
  }

  Future<void> fetchWeatherForCurrentCity() async {
    try {
      loadingWeather.value = true;

      // Get the current city
      final currentCity = GlobalManager().currentCity;
      if (currentCity == null) {
        Logger().e('No current city selected');
        return;
      }

      // Fetch weather data for the current city
      final weatherData = await fetchWeatherUseCase([currentCity]);
      final weather = weatherData[currentCity.id];

      if (weather != null) {
        final cityWeather = CityWeatherModel(
          city: currentCity,
          temperature: weather.temperature,
          humidity: weather.humidity,
          pressure: weather.pressure,
          hourlyTemperatures: nextHoursWeather,
          dailyTemperatures: nextDaysWeather,
        );

        // Update the global state or any other state management
        Logger().i('CityWeatherModel updated: $cityWeather');
        await saveLastUpdated();
      }
    } catch (e) {
      Logger().e('Error fetching weather for current city: $e');
    } finally {
      loadingWeather.value = false;
    }
  }

  Future<void> fetchForecastForCurrentCity() async {
    try {
      loadingWeather.value = true;

      // Get the current city
      final currentCity = GlobalManager().currentCity;
      if (currentCity == null) {
        Logger().e('No current city selected');
        return;
      }

      // Fetch forecast data for the current city
      final forecast = await fetchWeatherUseCase.weatherRepository.fetchForecastFromServer(
        lat: currentCity.lat,
        lon: currentCity.long,
        unit: GlobalManager().temperatureUnit.value,
      );

      if (forecast != null) {
        forecastData.assignAll(forecast);
        Logger().i('Forecast data updated: $forecast');
      }
    } catch (e) {
      Logger().e('Error fetching forecast for current city: $e');
    } finally {
      loadingWeather.value = false;
    }
  }

  Future<void> updateSelectedCity(int index) async {
    try {
      if (GlobalManager().loading.value) {
        return;
      }

      // Waits the card selection animation to finish
      await Future.delayed(const Duration(milliseconds: 500));
      GlobalManager().loading.value = true;
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (index >= 0 && index < cities.length) {
        GlobalManager().updateCurrentCity(cities[index]);
      }
    } finally {
      GlobalManager().loading.value = false;
    }
  }
}
