import 'package:get/get.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/core/constants/locale.constants.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/city.model.dart';

class GlobalManager {
  factory GlobalManager() => _instance;
  GlobalManager._privateConstructor();

  static final GlobalManager _instance = GlobalManager._privateConstructor();

  final _currentCity = Rxn<CityModel>();
  final _environment = Rxn<MainAppEnvironment>();
  final _currentLocale = Rxn<String>(kDefaultLocale.languageCode);
  final loading = true.obs;
  final temperatureUnit = Rxn<TemperatureUnits>(TemperatureUnits.celsius);

  CityModel? get currentCity => _currentCity.value;
  MainAppEnvironment? get environment => _environment.value;
  String? get currentLocale => _currentLocale.value;

  void updateCurrentCity(CityModel city) {
    _currentCity.value = city;
  }

  void updateEnvironment(MainAppEnvironment env) {
    _environment.value = env;
  }

  void updateTemperatureUnit(TemperatureUnits unit) {
    temperatureUnit.value = unit;
  }

  void updateCurrentLocale(String? locale) {
    locale ??= kDefaultLocale.languageCode;
    _currentLocale.value = locale;
  }
}
