import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/domain/usecases/fetch_hourly_forecast.usecase.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('FetchHourlyForecastUseCase', () {
    late MockWeatherRepository mockWeatherRepository;
    late FetchHourlyForecastUseCase useCase;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      useCase = FetchHourlyForecastUseCase(mockWeatherRepository);
    });

    test('should return hourly forecast for the current day', () async {
      final mockHourlyWeather = [
        DayHourWeatherModel(
          dateTime: DateTime.now(),
          currentHour: 12,
          temperature: 25,
          weather: 'Sunny',
        ),
      ];

      when(
        mockWeatherRepository.fetchHourlyForecastFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).thenAnswer((_) async => mockHourlyWeather);

      final result = await useCase.call(lat: '0', lon: '0');

      expect(result, isNotEmpty);
      verify(
        mockWeatherRepository.fetchHourlyForecastFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).called(1);
    });
  });
}
