import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';

const List<double> _kDefaultLinearGradientStops = [0.6, 1];

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
  final double temperature;
  final double? humidity;
  final double? pressure;
  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 10),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      gradient: _getLinearBackground(condition),
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Stack(
      children: [
        Positioned(
          top: -20,
          right: -20,
          child: _buildWeatherIcon(context, condition),
        ),
        Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily:
                      GoogleFonts.archivo(
                        fontWeight: FontWeight.w800,
                      ).fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$temperature°C',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily:
                      GoogleFonts.archivo(
                        fontWeight: FontWeight.w800,
                      ).fontFamily,
                ),
              ),
              if (humidity != null) ...[
                _getBottomCardText('Humidity: $humidity%'),
              ],
              if (pressure != null) ...[
                _getBottomCardText('Pressure: $pressure hPa'),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  Widget _getBottomCardText(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );

  // Helper function to get the linear gradient background based on the weather condition
  LinearGradient _getLinearBackground(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.scorching:
        return const LinearGradient(
          colors: [Color(0xFFFF5108), Color(0xFFFF8D5D)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: _kDefaultLinearGradientStops,
        );
      case WeatherCondition.sunny:
        return const LinearGradient(
          colors: [Color(0xFF53B6D7), Color(0xFF8ACDE2)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: _kDefaultLinearGradientStops,
        );

      case WeatherCondition.cloudy:
        return const LinearGradient(
          colors: [Color(0xFFA0AEC0), Color(0xFFE2E8F0)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: _kDefaultLinearGradientStops,
        );
      default:
        return const LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  // Helper function to build the weather icon (sun or cloud)
  Widget _buildWeatherIcon(BuildContext context, WeatherCondition condition) {
    final size = MediaQuery.of(context).size.width * 0.25;

    switch (condition) {
      case WeatherCondition.sunny:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFFF6AD55),
                Color(0xFF74C4DE),
                Color(0xFF74C4DE).withValues(alpha: 0),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.4, 0.82, 1],
            ),
          ),
        );
      case WeatherCondition.cloudy:
        return SvgPicture.asset(
          'assets/images/illustrations/cloud.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(Color(0xFFA0AEC0), BlendMode.srcATop),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
