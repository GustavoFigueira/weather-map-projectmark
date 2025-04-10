import 'package:get/get.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/city.model.dart';

class GlobalStateManager {
  factory GlobalStateManager() => _instance;
  GlobalStateManager._privateConstructor();

  static final GlobalStateManager _instance =
      GlobalStateManager._privateConstructor();

  final _currentCity = Rxn<CityModel>();
  final _environment = Rxn<MainAppEnvironment>();
  final loading = true.obs;
  final temperatureUnit = TemperatureUnits.celsius.obs;

  CityModel? get currentCity => _currentCity.value;
  MainAppEnvironment? get environment => _environment.value;

  void updateCurrentCity(CityModel city) {
    _currentCity.value = city;
  }

  void updateEnvironment(MainAppEnvironment env) {
    _environment.value = env;
  }
}
