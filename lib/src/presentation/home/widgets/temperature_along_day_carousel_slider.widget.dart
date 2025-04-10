import 'package:flutter/material.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/presentation/home/widgets/day_hour_temperature_tile_card.widget.dart';

class TemperatureAlongDayCarouselSlider extends StatelessWidget {
  const TemperatureAlongDayCarouselSlider({
    super.key,
    this.loading = false,
    required this.nextHoursWeather,
  });

  final bool loading;
  final List<DayHourWeatherModel> nextHoursWeather;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 118,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: nextHoursWeather.length,
        itemBuilder: (context, index) {
          final weather = nextHoursWeather[index];
          final isCurrentHour = DateTime.now().hour == weather.currentHour;

          return DayHourTemperatureTileCard(
            time: '${weather.currentHour}:00',
            temperature: weather.temperature,
            condition: weather.condition,
            isCurrentHour: isCurrentHour,
            hasLeftPadding: index == 0,
            hasRightPadding: index == nextHoursWeather.length - 1,
          );
        },
      ),
    );
  }
}
