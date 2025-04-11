import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_map/src/core/helpers/measuring_units.helper.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';

void main() {
  group('TemperatureFormatting', () {
    late GlobalManager globalManager;

    setUp(() {
      globalManager = GlobalManager();
      Get.put(globalManager);
    });

    tearDown(Get.reset);

    test('should format temperature in Celsius', () {
      globalManager.updateTemperatureUnit(TemperatureUnits.celsius);
      const temperature = 25.0;

      final formatted = temperature.formatTemperature();

      expect(formatted, '25 °C');
    });

    test('should format temperature in Fahrenheit', () {
      globalManager.updateTemperatureUnit(TemperatureUnits.fahrenheit);
      const temperature = 77.0;

      final formatted = temperature.formatTemperature();

      expect(formatted, '77 °F');
    });

    test('should format degrees without unit', () {
      const temperature = 25.0;

      final formatted = temperature.formatDegrees();

      expect(formatted, '25°');
    });
  });
}
