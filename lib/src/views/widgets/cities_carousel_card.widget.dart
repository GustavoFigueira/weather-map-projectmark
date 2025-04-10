import 'package:flutter/material.dart';

enum WeatherCondition { hot, sunny, rainy, cloudy, snowy }

class CitiesCarouselCard extends StatelessWidget {
  const CitiesCarouselCard({
    super.key,
    required this.location,
    required this.temperature,
    this.humidity,
    this.pressure,
    this.condition = WeatherCondition.sunny,
  });

  final String location;
  final String temperature;
  final String? humidity;
  final String? pressure;
  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: _getBackgroundColor(condition),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Positioned sun or cloud drawing
          Positioned(top: 10, right: 10, child: _buildWeatherIcon(condition)),
          // Content of the card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('$temperature°C', style: const TextStyle(fontSize: 16)),
                if (humidity != null) ...[
                  const SizedBox(height: 8),
                  Text('Humidity: $humidity%'),
                ],
                if (pressure != null) ...[
                  const SizedBox(height: 8),
                  Text('Pressure: $pressure hPa'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to get the background color based on the weather condition
  Color _getBackgroundColor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return Colors.blue;
      case WeatherCondition.hot:
        return Colors.orange;
      case WeatherCondition.cloudy:
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  // Helper function to build the weather icon (sun or cloud)
  Widget _buildWeatherIcon(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      case WeatherCondition.cloudy:
        return Image.asset(
          'assets/images/illustrations/illustrations.svg',
          width: 50,
          height: 50,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
