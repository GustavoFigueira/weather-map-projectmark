import 'package:dio/dio.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class WeatherRepository {
  static const String _apiKey = 'API_KEY';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  final DioClient _dioClient;

  WeatherRepository(this._dioClient);

  Future<WeatherModel?> fetchWeatherFromServer({
    required String lat,
    required String lon,
  }) async {
    try {
      final response = await _dioClient.get(
        _baseUrl,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
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
}