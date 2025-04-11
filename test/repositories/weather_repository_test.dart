import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  group('WeatherRepository', () {
    late MockDioClient mockDioClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      mockDioClient = MockDioClient();
      weatherRepository = WeatherRepository(mockDioClient);
    });

    test('fetchWeatherFromServer returns WeatherModel on success', () async {
      const lat = '26.3044';
      const lon = '-48.8456';

      final mockResponse = {
        'coord': {'lon': -48.8456, 'lat': -26.3044},
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04d',
          },
        ],
        'main': {
          'temp': 22.77,
          'feels_like': 23.71,
          'temp_min': 22.77,
          'temp_max': 22.77,
          'pressure': 1017,
          'humidity': 100,
        },
        'name': 'Joinville',
        'cod': 200,
      };

      when(
        mockDioClient.get(
          'https://api.openweathermap.org/data/2.5',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await weatherRepository.fetchWeatherFromServer(
        lat: lat,
        lon: lon,
      );

      expect(result, isA<WeatherModel>());
      expect(result?.temperature, 22.77);
      expect(result?.humidity, 100);
    });

    test('fetchWeatherFromServer returns null on failure', () async {
      const lat = '26.3044';
      const lon = '-48.8456';

      when(
        mockDioClient.get(
          'https://api.openweathermap.org/data/2.5',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 404, requestOptions: RequestOptions()),
      );

      final result = await weatherRepository.fetchWeatherFromServer(
        lat: lat,
        lon: lon,
      );

      expect(result, isNull);
    });

    test(
      'fetchWeekForecastFromServer returns list of DailyForecastModel on success',
      () async {
        const lat = '44.34';
        const lon = '10.99';
        const days = 2;

        final mockResponse = {
          'cod': '200',
          'message': 0,
          'cnt': 2,
          'list': [
            {
              'dt': 1744394400,
              'main': {
                'temp': 288.27,
                'feels_like': 287.59,
                'temp_min': 280.45,
                'temp_max': 288.27,
                'pressure': 1014,
                'humidity': 67,
              },
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01n',
                },
              ],
              'dt_txt': '2025-04-11 18:00:00',
            },
            {
              'dt': 1744405200,
              'main': {
                'temp': 285.72,
                'feels_like': 285.1,
                'temp_min': 282.49,
                'temp_max': 285.72,
                'pressure': 1016,
                'humidity': 79,
              },
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01n',
                },
              ],
              'dt_txt': '2025-04-11 21:00:00',
            },
          ],
        };

        when(
          mockDioClient.get(
            'any',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );

        final result = await weatherRepository.fetchWeekForecastFromServer(
          lat: lat,
          lon: lon,
          days: days,
        );

        expect(result, isNotNull);
        expect(result?.length, 2);
      },
    );

    test(
      'fetchHourlyForecastFromServer returns list of DayHourWeatherModel on success',
      () async {
        const lat = '44.34';
        const lon = '10.99';

        final mockResponse = {
          'cod': '200',
          'message': 0,
          'cnt': 2,
          'list': [
            {
              'dt': 1744394400,
              'main': {
                'temp': 288.27,
                'feels_like': 287.59,
                'temp_min': 280.45,
                'temp_max': 288.27,
                'pressure': 1014,
                'humidity': 67,
              },
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01n',
                },
              ],
              'dt_txt': '2025-04-11 18:00:00',
            },
            {
              'dt': 1744405200,
              'main': {
                'temp': 285.72,
                'feels_like': 285.1,
                'temp_min': 282.49,
                'temp_max': 285.72,
                'pressure': 1016,
                'humidity': 79,
              },
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01n',
                },
              ],
              'dt_txt': '2025-04-11 21:00:00',
            },
          ],
        };

        when(
          mockDioClient.get(
            'any',
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );

        final result = await weatherRepository.fetchHourlyForecastFromServer(
          lat: lat,
          lon: lon,
        );

        expect(result, isNotNull);
        expect(result?.length, 2);
      },
    );
  });
}
