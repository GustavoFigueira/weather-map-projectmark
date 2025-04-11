import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_map/app/config/flavors.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';

class MockMainAppEnvironment extends Mock implements MainAppEnvironment {}

class MockDio extends Mock implements Dio {}

void main() {
  group('DioClient', () {
    late MockMainAppEnvironment mockEnvironment;
    late MockDio mockDio;
    late DioClient dioClient;

    setUp(() {
      mockEnvironment = MockMainAppEnvironment();
      mockDio = MockDio();
      dioClient = DioClient(environment: mockEnvironment, dio: mockDio);
    });

    test(
      'should make a GET request to the correct URL with query parameters',
      () async {
        const endpoint = '/weather';
        final queryParameters = {'q': 'London', 'units': 'metric'};
        final mockResponse = Response(
          requestOptions: RequestOptions(),
          data: {'weather': 'Sunny'},
          statusCode: 200,
        );

        when(
          mockEnvironment.baseUrl,
        ).thenReturn(Uri.parse('https://api.openweathermap.org/data/2.5'));
        when(mockEnvironment.openWeatherMapApiKey).thenReturn('test_api_key');
        when(
          mockDio.get('any', queryParameters: anyNamed('queryParameters')),
        ).thenAnswer((_) async => mockResponse);

        final response = await dioClient.get(
          endpoint,
          queryParameters: queryParameters,
        );

        expect(response.data, {'weather': 'Sunny'});
        verify(
          mockDio.get(
            'https://api.openweathermap.org/data/2.5/weather',
            queryParameters: {
              'q': 'London',
              'units': 'metric',
              'appid': 'test_api_key',
            },
          ),
        ).called(1);
      },
    );

    test('should log and rethrow DioException on failure', () async {
      const endpoint = '/weather';
      final queryParameters = {'q': 'London', 'units': 'metric'};
      final dioException = DioException(requestOptions: RequestOptions());

      when(
        mockEnvironment.baseUrl,
      ).thenReturn(Uri.parse('https://api.openweathermap.org/data/2.5'));
      when(mockEnvironment.openWeatherMapApiKey).thenReturn('test_api_key');
      when(
        mockDio.get('any', queryParameters: anyNamed('queryParameters')),
      ).thenThrow(dioException);

      expect(
        () async => dioClient.get(endpoint, queryParameters: queryParameters),
        throwsA(isA<DioException>()),
      );
      verify(
        mockDio.get(
          'https://api.openweathermap.org/data/2.5/weather',
          queryParameters: {
            'q': 'London',
            'units': 'metric',
            'appid': 'test_api_key',
          },
        ),
      ).called(1);
    });
  });
}
