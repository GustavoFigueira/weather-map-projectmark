import 'package:get/get.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/city.model.dart';

class GlobalStateManager {
  GlobalStateManager._privateConstructor();

  static final GlobalStateManager _instance =
      GlobalStateManager._privateConstructor();

  factory GlobalStateManager() {
    return _instance;
  }

  final currentCity = Rxn<CityModel>();
  final loading = true.obs;
  final temperatureUnit = TemperatureUnits.celsius.obs;
  final environment = Rxn<MainAppEnvironment>();

  void updateCurrentCity(CityModel city) {
    currentCity.value = city;
  }

  void updateEnvironment(MainAppEnvironment env) {
    environment.value = env;
  }
}
