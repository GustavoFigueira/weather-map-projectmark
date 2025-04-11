import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';

class FetchForecastUseCase {
  final WeatherRepository weatherRepository;

  FetchForecastUseCase(this.weatherRepository);

  Future<List<DailyForecastModel>?> call({
    required String lat,
    required String lon,
    TemperatureUnits? unit = TemperatureUnits.celsius,
    int days = 7,
  }) async => weatherRepository.fetchWeekForecastFromServer(
    lat: lat,
    lon: lon,
    unit: unit,
    days: days,
  );
}
