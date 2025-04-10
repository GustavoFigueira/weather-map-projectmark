import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
              ),
            );

  /// Makes a GET request.
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      // Custom error handling or logging can be implemented here.
      throw e;
    }
  }

  // You can add other helper methods (e.g. post, put, delete) if needed.
}
