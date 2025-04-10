import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/views/home_view.dart';
import 'package:weather_map/src/views/widgets/cities_carousel_card.widget.dart';

class CitiesHorizontalCarouselSlider extends StatefulWidget {
  const CitiesHorizontalCarouselSlider({super.key});

  @override
  CitiesHorizontalCarouselSliderState createState() =>
      CitiesHorizontalCarouselSliderState();
}

class CitiesHorizontalCarouselSliderState extends State<CitiesHorizontalCarouselSlider> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<Widget> _cards = [
    Padding(
      padding: EdgeInsets.only(left: kHomeDefaultSpacing),
      child: CitiesCarouselCard(
        location: 'New York',
        temperature: 25,
        humidity: 60,
        pressure: 1012,
      ),
    ),
    CitiesCarouselCard(
      location: 'Los Angeles',
      temperature: 30,
      humidity: 50,
      pressure: 1010,
      condition: WeatherCondition.scorching,
    ),
    Padding(
      padding: EdgeInsets.only(right: kHomeDefaultSpacing),
      child: CitiesCarouselCard(
        location: 'Chicago',
        temperature: 20,
        humidity: 70,
        pressure: 1015,
        condition: WeatherCondition.cloudy,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _cards,
          options: CarouselOptions(
            height: 194,
            enableInfiniteScroll: false,
            disableCenter: true,
            padEnds: false,
            onPageChanged: (index, reason) {
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
              _cards.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 9,
                    height: 9,
                    margin: EdgeInsets.symmetric(horizontal: 7),
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
