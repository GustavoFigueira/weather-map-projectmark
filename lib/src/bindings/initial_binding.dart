import 'package:get/get.dart';
import 'package:weather_map/src/features/home/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the WeatherController so it's available through the app.
    Get.put(HomeController());
  }
}
