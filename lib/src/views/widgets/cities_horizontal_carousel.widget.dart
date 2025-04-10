import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/views/widgets/cities_carousel_card.widget.dart';

class CitiesHorizontalCarousel extends StatefulWidget {
  const CitiesHorizontalCarousel({super.key});

  @override
  CitiesHorizontalCarouselState createState() =>
      CitiesHorizontalCarouselState();
}

class CitiesHorizontalCarouselState extends State<CitiesHorizontalCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<Widget> _cards = [
    CitiesCarouselCard(
      location: 'New York',
      temperature: '25°C',
      humidity: '60%',
      pressure: '1013 hPa',
    ),
    CitiesCarouselCard(
      location: 'Los Angeles',
      temperature: '30°C',
      humidity: '50%',
      pressure: '1010 hPa',
    ),
    CitiesCarouselCard(
      location: 'Chicago',
      temperature: '20°C',
      humidity: '70%',
      pressure: '1015 hPa',
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
