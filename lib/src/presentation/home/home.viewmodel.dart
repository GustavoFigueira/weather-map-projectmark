import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/src/data/constants/default_cities.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/city_weather.model.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/domain/usecases/fetch_city_weather.usecase.dart';
import 'package:weather_map/src/domain/usecases/fetch_forecast.usecase.dart';
import 'package:weather_map/src/domain/usecases/fetch_hourly_forecast.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';

class HomeViewModel extends GetxController {
  HomeViewModel(
    this.fetchCityWeatherUseCase,
    this.fetchForecastUseCase,
    this.fetchHourlyForecastUseCase,
  );

  final FetchCityWeatherUseCase fetchCityWeatherUseCase;
  final FetchForecastUseCase fetchForecastUseCase;
  final FetchHourlyForecastUseCase fetchHourlyForecastUseCase;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _refreshTimer;

  final cities = <CityModel>[].obs;
  final citiesWeatherData = <CityModel, WeatherModel?>{}.obs;
  final dailyForecastData = <DailyForecastModel>[].obs;
  final nextHoursWeather = <DayHourWeatherModel>[].obs;
  final loadingCities = false.obs;
  final loadingWeather = false.obs;
  final lastUpdated = Rxn<DateTime>();

  List<CityModel> get currentCities => cities;

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
        fetchForecastForCurrentCity();
        fetchHourlyWeatherForCurrentCity();
      });
    } catch (e) {
      Logger().e('Error initializing data: $e');
    } finally {
      GlobalManager().loading.value = false;
    }
  }

  Future<void> refreshData() async {
    try {
      loadingWeather.value = true;
      Future.wait([
        fetchWeatherForCities(),
        fetchForecastForCurrentCity(),
        fetchHourlyWeatherForCurrentCity(),
      ]).then((_) {
        saveLastUpdated();
      });
    } catch (e) {
      Logger().e('Error refreshing data: $e');
    } finally {
      loadingWeather.value = false;
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
      final weatherDataMap = await fetchCityWeatherUseCase(cities);
      citiesWeatherData.assignAll(weatherDataMap);
      saveLastUpdated();
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
      final weatherData = await fetchCityWeatherUseCase([currentCity]);
      final weather = weatherData[currentCity];

      if (weather != null) {
        final cityWeather = CityWeatherModel(
          city: currentCity,
          temperature: weather.temperature,
          humidity: weather.humidity,
          pressure: weather.pressure,
          hourlyTemperatures: nextHoursWeather,
          dailyTemperatures: dailyForecastData,
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

      final currentCity = GlobalManager().currentCity;
      if (currentCity == null) {
        Logger().e('No current city selected');
        return;
      }

      final forecast = await fetchForecastUseCase.call(
        lat: currentCity.lat,
        lon: currentCity.long,
        unit: GlobalManager().temperatureUnit.value,
      );

      if (forecast != null) {
        dailyForecastData.assignAll(forecast);
        Logger().i('Forecast data updated: $forecast');
      }
    } catch (e) {
      Logger().e('Error fetching forecast for current city: $e');
    } finally {
      loadingWeather.value = false;
    }
  }

  Future<void> fetchHourlyWeatherForCurrentCity() async {
    try {
      loadingWeather.value = true;

      final currentCity = GlobalManager().currentCity;
      if (currentCity == null) {
        Logger().e('No current city selected');
        return;
      }

      final hourlyWeather = await fetchHourlyForecastUseCase.call(
        lat: currentCity.lat,
        lon: currentCity.long,
        unit: GlobalManager().temperatureUnit.value,
        currentWeather: citiesWeatherData[currentCity],
      );

      if (hourlyWeather != null) {
        nextHoursWeather.assignAll(hourlyWeather);
        Logger().i('Hourly weather data updated: $hourlyWeather');
      }
    } catch (e) {
      Logger().e('Error fetching hourly weather for current city: $e');
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
        refreshData();
      }
    } finally {
      GlobalManager().loading.value = false;
    }
  }
}
