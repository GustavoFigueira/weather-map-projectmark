import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/domain/usecases/fetch_city_weather.usecase.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('FetchCityWeatherUseCase', () {
    late MockWeatherRepository mockWeatherRepository;
    late FetchCityWeatherUseCase useCase;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      useCase = FetchCityWeatherUseCase(mockWeatherRepository);
    });

    test('should return weather data for a list of cities', () async {
      final mockCity = CityModel(
        id: 1,
        name: 'City',
        lat: '0',
        long: '0',
        label: 'City',
        state: 'State',
        country: 'Country',
        countryShort: 'CS',
      );
      final mockWeather = WeatherModel(
        temperature: 25,
        weather: 'Sunny',
        humidity: 50,
        pressure: 1013,
        tempMin: 20,
        tempMax: 30,
      );

      when(
        mockWeatherRepository.fetchWeatherFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).thenAnswer((_) async => mockWeather);

      when(
        mockWeatherRepository.fetchWeatherFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).thenAnswer((_) async => mockWeather);

      final result = await useCase.call([mockCity]);

      expect(result, containsPair(mockCity, mockWeather));
      verify(
        mockWeatherRepository.fetchWeatherFromServer(
          lat: '0',
          lon: '0',
          unit: anyNamed('unit'),
        ),
      ).called(1);
    });
  });
}
