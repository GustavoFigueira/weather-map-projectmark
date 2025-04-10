import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/domain/models/city.model.dart';
import 'package:weather_map/src/presentation/home/home_view.dart';
import 'package:weather_map/src/presentation/home/widgets/cities_carousel_card.widget.dart';

class CitiesHorizontalCarouselSlider extends StatefulWidget {
  const CitiesHorizontalCarouselSlider({
    super.key,
    required this.cities,
    this.loading = false,
    this.onCitySelected,
  });

  final List<CityModel> cities;
  final bool loading;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryColor),
      );
    }

    if (widget.cities.isEmpty) {
      return const Center(
        child: Text(
          'No cities available',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      );
    }

    final cards =
        widget.cities.map((city) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHomeDefaultSpacing / 2,
            ),
            child: CitiesCarouselCard(
              location: city.name,
              temperature: 45,
              humidity: 60,
              pressure: 1013,
              // temperature: city.temperature,
              // humidity: city.humidity,
              // pressure: city.pressure,
            ),
          );
        }).toList();

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
              setState(() {
                _currentIndex = index;
              });
              widget.onCitySelected?.call(index);
            },
          ),
        ),
        const SizedBox(height: 21),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              cards.asMap().entries.map((entry) {
                return GestureDetector(
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
                );
              }).toList(),
        ),
      ],
    );
  }
}
