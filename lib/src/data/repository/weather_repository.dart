import 'package:dio/dio.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class WeatherRepository {
  WeatherRepository(this._dioClient);

  final DioClient _dioClient;

  Future<WeatherModel?> fetchWeatherFromServer({
    required String lat,
    required String lon,
    TemperatureUnits? unit = TemperatureUnits.celsius,
  }) async {
    try {
      final response = await _dioClient.get(
        '/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': unit == TemperatureUnits.celsius ? 'metric' : 'imperial',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
      return null;
    } on DioException {
      return null;
    }
  }

  Future<List<DailyForecastModel>?> fetchWeekForecastFromServer({
    required String lat,
    required String lon,
    TemperatureUnits? unit = TemperatureUnits.celsius,
    int days = 7,
  }) async {
    try {
      final response = await _dioClient.get(
        '/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': unit == TemperatureUnits.celsius ? 'metric' : 'imperial',
          'cnt': days,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> forecastList = response.data['list'];
        return forecastList
            .map((json) => DailyForecastModel.fromJson(json))
            .toList();
      }
      return null;
    } on DioException {
      return null;
    }
  }

  Future<List<DayHourWeatherModel>?> fetchHourlyForecastFromServer({
    required String lat,
    required String lon,
    TemperatureUnits? unit = TemperatureUnits.celsius,
    int timeSpan = 8,
  }) async {
    try {
      final response = await _dioClient.get(
        '/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': unit == TemperatureUnits.celsius ? 'metric' : 'imperial',
          'cnt': timeSpan,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> hourlyList = response.data['list'];
        return hourlyList
            .map((json) => DayHourWeatherModel.fromJson(json))
            .toList();
      }
      return null;
    } on DioException {
      return null;
    }
  }
}
