import 'package:dio/dio.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';

import '../models/weather.dart';

class WeatherService {
  // IMPORTANT: Replace with your actual API key.
  static const String _apiKey = 'YOUR_API_KEY';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  // Use our DioClient abstraction.
  static final DioClient _dioClient = DioClient();

  static Future<Weather?> fetchWeather({
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
      // Check for success.
      if (response.statusCode == 200) {
        // The response data is already a Map<String, dynamic>.
        return Weather.fromJson(response.data);
      } else {
        // If the server did not return a 200 OK response,
        // handle the error accordingly.
        return null;
      }
    } on DioException catch (e) {
      // Handle DioError accordingly.
      return null;
    }
  }
}
