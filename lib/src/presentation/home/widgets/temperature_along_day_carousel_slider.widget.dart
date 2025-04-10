import 'package:flutter/material.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';
import 'day_hour_temperature_tile_card.widget.dart';

class TemperatureAlongDayCarouselSlider extends StatelessWidget {
  const TemperatureAlongDayCarouselSlider({super.key, this.loading = false});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentHour = DateTime.now().hour;

    return SizedBox(
      height: 118,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          DayHourTemperatureTileCard(
            time: '08:00',
            temperature: 22.5,
            condition: WeatherCondition.sunny,
            isCurrentHour: true,
            hasLeftPadding: true,
          ),
          DayHourTemperatureTileCard(
            time: '12:00',
            temperature: 28.0,
            condition: WeatherCondition.scorching,
            isCurrentHour: currentHour == 12,
          ),
          DayHourTemperatureTileCard(
            time: '16:00',
            temperature: 18.0,
            condition: WeatherCondition.cloudy,
            isCurrentHour: currentHour == 16,
          ),
          DayHourTemperatureTileCard(
            time: '20:00',
            temperature: 15.0,
            condition: WeatherCondition.cloudy,
            isCurrentHour: currentHour == 20,
            hasRightPadding: true,
          ),
        ],
      ),
    );
  }
}
