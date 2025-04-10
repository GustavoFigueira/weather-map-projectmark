import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_map/app/config/flavors.dart';

class DioClient {
  final Dio _dio;
  final MainAppEnvironment _environment;

  DioClient({Dio? dio, required MainAppEnvironment environment})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ),
          ),
      _environment = environment;

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        _environment.baseUrl.toString() + endpoint,
        queryParameters: {
          ...?queryParameters,
          'appid': _environment.openWeatherMapApiKey,
        },
      );
      return response;
    } on DioException catch (e) {
      Logger().e('GET request failed: $e');
      rethrow;
    }
  }
}
