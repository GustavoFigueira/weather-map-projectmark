import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/data/constants/default_cities.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';

class HomeController extends GetxController {
  final FetchWeatherUseCase fetchWeatherUseCase;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController(this.fetchWeatherUseCase);

  final cities = <CityModel>[].obs;
  final weatherData = <int, WeatherModel?>{}.obs;
  final loadingCities = false.obs;
  final loadingWeather = false.obs;

  Timer? _refreshTimer;

  List<CityModel> get currentCities => cities;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupAutoRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  Future<void> _initializeData() async {
    GlobalStateManager().loading.value = true;
    try {
      Future.wait([fetchCities(), fetchWeatherForCities()]).then((_) {
        // Set the first city as the current city
        if (cities.isNotEmpty) {
          GlobalStateManager().updateCurrentCity(cities[0]);
        }
      });
    } catch (e) {
      Logger().e('Error initializing data: $e');
    } finally {
      GlobalStateManager().loading.value = false;
    }
  }

  void _setupAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchWeatherForCities();
    });
  }

  Future<void> fetchCities() async {
    try {
      // Open Hive box for cities
      final cityBox = await Hive.openBox<CityModel>('cities');

      // Load cached cities or use default cities
      if (cityBox.isNotEmpty) {
        cities.assignAll(cityBox.values.toList());
      } else {
        cities.assignAll(kDefaultAppCities);
        for (var city in cities) {
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
    } catch (e) {
      Logger().e('Error fetching weather data: $e');
    } finally {
      loadingWeather.value = false;
    }
  }

  void updateSelectedCity(int index) {
    if (index >= 0 && index < cities.length) {
      GlobalStateManager().updateCurrentCity(cities[index]);
    }
  }
}
