import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/daily_forecast.model.dart';
import 'package:weather_map/src/domain/usecases/fetch_forecast.usecase.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('FetchForecastUseCase', () {
    late MockWeatherRepository mockWeatherRepository;
    late FetchForecastUseCase useCase;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      useCase = FetchForecastUseCase(mockWeatherRepository);
    });

    test('should return a list of daily forecasts', () async {
      final mockDailyForecasts = [
        DailyForecastModel(
          date: DateTime.now(),
          weather: 'Sunny',
          minTemperature: 24,
          maxTemperature: 26,
        ),
      ];

      when(
        mockWeatherRepository.fetchWeekForecastFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).thenAnswer((_) async => mockDailyForecasts);

      final result = await useCase.call(lat: '0', lon: '0');

      expect(result, isNotEmpty);
      verify(
        mockWeatherRepository.fetchWeekForecastFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).called(1);
    });
  });
}
