import 'package:flutter/material.dart';
import 'package:weather_map/src/views/home_view.dart';
import 'package:weather_map/src/views/widgets/cities_carousel_card.widget.dart';

class DayHourTemperatureTileCard extends StatelessWidget {
  const DayHourTemperatureTileCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.condition,
    required this.isCurrentHour,
    this.hasLeftPadding = false,
    this.hasRightPadding = false,
  });

  final String time;
  final double temperature;
  final WeatherCondition condition;
  final bool isCurrentHour;
  final bool hasLeftPadding;
  final bool hasRightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: hasLeftPadding ? kHomeDefaultSpacing : 0,
        right: hasRightPadding ? kHomeDefaultSpacing : 10,
      ),
      child: Container(
        width: 87,
        height: 118,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isCurrentHour ? const Color(0xFFF6AD55) : Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust height based on content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getWeatherIcon(condition),
              size: 50,
              color: _getIconColor(condition),
            ),
            const SizedBox(height: 10),
            Text(
              '$temperature°C',
              style: TextStyle(fontSize: 16, color: _getTextColor(condition)),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(fontSize: 14, color: _getTextColor(condition)),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.scorching:
        return Icons.thermostat;
      case WeatherCondition.rainy:
        return Icons.umbrella;
      case WeatherCondition.snowy:
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getIconColor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return const Color(0xFFF6AD55);
      case WeatherCondition.cloudy:
        return const Color(0xFFA0AEC0);
      default:
        return Colors.black;
    }
  }

  Color _getTextColor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
      case WeatherCondition.cloudy:
        return const Color(0xFFA0AEC0);
      default:
        return Colors.black;
    }
  }
}