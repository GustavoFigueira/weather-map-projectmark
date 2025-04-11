import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/data/constants/default_cities.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/domain/models/weather.model.dart';
import 'package:weather_map/src/presentation/home/home.view.dart';
import 'package:weather_map/src/presentation/home/widgets/cities_carousel_card.widget.dart';

/// Fake data to simulate the Figma design.
final Map<CityModel, WeatherModel?> _fakeData = {
  kDefaultAppCities[0]: WeatherModel(
    temperature: 4,
    humidity: 87,
    pressure: 1016,
    tempMin: 0,
    tempMax: 10,
  ),
  kDefaultAppCities[1]: WeatherModel(
    temperature: 43,
    humidity: 15,
    pressure: 1010,
    tempMin: 0,
    tempMax: 44,
  ),
  kDefaultAppCities[2]: WeatherModel(
    temperature: 10,
    humidity: 85,
    pressure: 1013,
    tempMin: 0,
    tempMax: 20,
  ),
};

class CitiesHorizontalCarouselSlider extends StatefulWidget {
  const CitiesHorizontalCarouselSlider({
    super.key,
    required this.citiesWeatherData,
    this.loading = false,
    this.useFakeData = false,
    this.onCitySelected,
  });

  final Map<CityModel, WeatherModel?> citiesWeatherData;
  final bool loading;
  final bool useFakeData;
  final void Function(int index)? onCitySelected;

  @override
  CitiesHorizontalCarouselSliderState createState() =>
      CitiesHorizontalCarouselSliderState();
}

class CitiesHorizontalCarouselSliderState
    extends State<CitiesHorizontalCarouselSlider> {
  int _currentIndex = 0;
  final _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryColor),
      );
    }

    if (widget.citiesWeatherData.isEmpty) {
      return const Center(
        child: Text(
          'No cities available',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      );
    }

    final dataEntries =
        widget.useFakeData
            ? _fakeData.entries
            : widget.citiesWeatherData.entries;

    final cards =
        dataEntries
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(left: kHomeDefaultSpacing),
                child: CitiesCarouselCard(
                  location: entry.key,
                  temperature: entry.value?.temperature ?? 0,
                  humidity: entry.value?.humidity,
                  pressure: entry.value?.pressure,
                ),
              ),
            )
            .toList();

    return Column(
      children: [
        CarouselSlider(
          items: cards,
          options: CarouselOptions(
            height: 194,
            enableInfiniteScroll: false,
            disableCenter: true,
            padEnds: false,
            onPageChanged: (index, reason) {
              widget.onCitySelected?.call(index);
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 21),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              cards
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 9,
                        height: 9,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentIndex == entry.key
                                  ? AppTheme.primaryColor
                                  : AppTheme.accentColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
