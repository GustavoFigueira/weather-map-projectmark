import 'package:get/get.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/usecases/fetch_city_weather.usecase.dart';
import 'package:weather_map/src/domain/usecases/fetch_forecast.usecase.dart';
import 'package:weather_map/src/domain/usecases/fetch_hourly_forecast.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
import 'package:weather_map/src/presentation/home/home.viewmodel.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize GlobalStateManager
    final globalStateManager = Get.put(GlobalManager());

    // Initialize DioClient with environment from GlobalStateManager
    Get
      ..lazyPut(() => DioClient(environment: globalStateManager.environment!))
      // Initialize WeatherRepository
      ..lazyPut(() => WeatherRepository(Get.find<DioClient>()))
      // Initialize FetchWeatherUseCase
      ..lazyPut(() => FetchCityWeatherUseCase(Get.find<WeatherRepository>()))
      // Initialize FetchForecastUseCase
      ..lazyPut(() => FetchForecastUseCase(Get.find<WeatherRepository>()))
      // Initialize FetchHourlyForecastUseCase
      ..lazyPut(() => FetchHourlyForecastUseCase(Get.find<WeatherRepository>()))
      // Initialize HomeController
      ..put(
        HomeViewModel(
          Get.find<FetchCityWeatherUseCase>(),
          Get.find<FetchForecastUseCase>(),
          Get.find<FetchHourlyForecastUseCase>(),
        ),
      );
  }
}
