import 'package:get/get.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';

extension TemperatureFormatting on double {
  String formatTemperature() {
    final unit = Get.find<GlobalManager>().temperatureUnit.value;
    if (unit == TemperatureUnits.celsius) {
      return '${toStringAsFixed(0)} °C';
    } else if (unit == TemperatureUnits.fahrenheit) {
      return '${toStringAsFixed(0)} °F';
    } else {
      throw Exception('Unsupported temperature unit');
    }
  }

  String formatDegrees() => '${toStringAsFixed(0)}°';
}
