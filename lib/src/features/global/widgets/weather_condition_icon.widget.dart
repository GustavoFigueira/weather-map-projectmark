import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_map/src/features/home/widgets/cities_carousel_card.widget.dart';

class WeatherConditionIcon extends StatelessWidget {
  final WeatherCondition condition;

  const WeatherConditionIcon({super.key, required this.condition});

  String _getIconPath() {
    switch (condition) {
      case WeatherCondition.sunny:
        return 'assets/images/icons/sun-outline.svg';
      case WeatherCondition.cloudy:
        return 'assets/images/icons/cloud-rain.svg';
      case WeatherCondition.rainy:
        return 'assets/images/icons/cloud-lightning.svg';
      default:
        return 'assets/images/icons/cloud-outline.svg';
    }
  }

  @override
  Widget build(BuildContext context) =>
      SvgPicture.asset(_getIconPath(), width: 34, height: 34);
}
