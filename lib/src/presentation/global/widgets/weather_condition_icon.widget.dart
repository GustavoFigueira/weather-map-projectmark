import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

class WeatherConditionIcon extends StatelessWidget {
  final WeatherCondition condition;
  final Color? fill; // Nullable custom color property

  const WeatherConditionIcon({super.key, required this.condition, this.fill});

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
  Widget build(BuildContext context) => SvgPicture.asset(
    _getIconPath(),
    colorFilter: fill != null ? ColorFilter.mode(fill!, BlendMode.srcIn) : null,
  );
}
