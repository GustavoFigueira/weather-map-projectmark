import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/src/data/constants/default_cities.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';
import 'package:weather_map/src/presentation/home/home_viewmodel.dart';

class HomeController extends GetxController {
  HomeController(this.model, this.fetchWeatherUseCase);

  final FetchWeatherUseCase fetchWeatherUseCase;
  final HomeViewModel model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _refreshTimer;

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
        if (model.cities.isNotEmpty) {
          GlobalStateManager().updateCurrentCity(model.cities[0]);
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
      model.loadingCities.value = true;

      // Open Hive box for cities
      final cityBox = await Hive.openBox<CityModel>('cities');

      // Load cached cities or use default cities
      if (cityBox.isNotEmpty) {
        model.cities.assignAll(cityBox.values.toList());
      } else {
        model.cities.assignAll(kDefaultAppCities);
        for (final city in model.cities) {
          cityBox.put(city.id, city);
        }
      }
    } catch (e) {
      Logger().e('Error fetching cities: $e');
    } finally {
      model.loadingCities.value = false;
    }
  }

  Future<void> fetchWeatherForCities() async {
    try {
      model.loadingWeather.value = true;
      final weatherDataMap = await fetchWeatherUseCase(model.cities);
      model.weatherData.assignAll(weatherDataMap);
    } catch (e) {
      Logger().e('Error fetching weather data: $e');
    } finally {
      model.loadingWeather.value = false;
    }
  }

  Future<void> updateSelectedCity(int index) async {
    try {
      if (GlobalStateManager().loading.value) {
        return;
      }

      // Waits the card selection animation to finish
      await Future.delayed(const Duration(milliseconds: 500));
      GlobalStateManager().loading.value = true;
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (index >= 0 && index < model.cities.length) {
        GlobalStateManager().updateCurrentCity(model.cities[index]);
      }
    } finally {
      GlobalStateManager().loading.value = false;
    }
  }
}
