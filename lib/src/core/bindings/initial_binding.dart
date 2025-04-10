import 'package:get/get.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';
import 'package:weather_map/src/presentation/home/home_controller.dart';
import 'package:weather_map/src/presentation/home/home_viewmodel.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize GlobalStateManager
    final globalStateManager = Get.put(GlobalStateManager());

    // Initialize DioClient with environment from GlobalStateManager
    Get
      ..lazyPut(() => DioClient(environment: globalStateManager.environment!))
      // Initialize WeatherRepository
      ..lazyPut(() => WeatherRepository(Get.find<DioClient>()))
      // Initialize HomeViewModel
      ..lazyPut(() => HomeViewModel.new)
      // Initialize FetchWeatherUseCase
      ..lazyPut(() => FetchWeatherUseCase(Get.find<WeatherRepository>()))
      // Initialize HomeController
      ..put(
        HomeController(
          Get.find<HomeViewModel>(),
          Get.find<FetchWeatherUseCase>(),
        ),
      );
  }
}
