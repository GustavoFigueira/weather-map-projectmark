import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';

class HomeController extends GetxController {
  final FetchWeatherUseCase fetchWeatherUseCase;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController(this.fetchWeatherUseCase);

  final cities = <CityModel>[].obs;
  final weatherData = <int, WeatherModel?>{}.obs;
  final loading = true.obs;

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
    loading.value = true;
    try {
      // Open Hive box for cities
      final cityBox = await Hive.openBox<CityModel>('cities');

      // Load cached cities or use default cities
      if (cityBox.isNotEmpty) {
        cities.assignAll(cityBox.values.toList());
      } else {
        cities.assignAll(_defaultCities());
        for (var city in cities) {
          cityBox.put(city.id, city);
        }
      }

      // Fetch weather data
      await fetchWeatherForCities();
    } catch (e) {
      Logger().e('Error initializing data: $e');
    } finally {
      loading.value = false;
    }
  }

  void _setupAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchWeatherForCities();
    });
  }

  Future<void> fetchWeatherForCities() async {
    loading.value = true;

    final fetchedWeatherData = await fetchWeatherUseCase.call(cities);
    weatherData.assignAll(fetchedWeatherData);

    loading.value = false;
  }

  List<CityModel> _defaultCities() {
    return [
      CityModel(
        id: 1,
        label: 'Joinville - SC - Brazil',
        name: 'Joinville',
        state: 'SC',
        country: 'Brazil',
        countryShort: 'BR',
        lat: '-26.30444000',
        long: '-48.84556000',
      ),
      CityModel(
        id: 2,
        label: 'San Francisco - CA - USA',
        name: 'San Francisco',
        state: 'CA',
        country: 'USA',
        countryShort: 'USA',
        lat: '37.77493000',
        long: '-122.41942000',
      ),
      CityModel(
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
  }
}
