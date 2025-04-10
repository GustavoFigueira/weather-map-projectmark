import 'package:get/get.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';
import 'package:weather_map/src/presentation/home/home_controller.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize DioClient
    Get.lazyPut(() => DioClient());

    // Initialize WeatherRepository
    Get.lazyPut(() => WeatherRepository(Get.find<DioClient>()));

    // Initialize FetchWeatherUseCase
    Get.lazyPut(() => FetchWeatherUseCase(Get.find<WeatherRepository>()));

    // Initialize HomeController
    Get.put(HomeController(Get.find<FetchWeatherUseCase>()));

    // Initialize GlobalStateManager
    Get.put(GlobalStateManager());
  }
}
