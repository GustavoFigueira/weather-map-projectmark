import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_map/src/domain/models/day_hour_weather.model.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
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
          final formattedTime = DateFormat.jm(
            GlobalManager().currentLocale,
          ).format(DateTime(0, 1, 1, weather.currentHour));

          return DayHourTemperatureTileCard(
            time: formattedTime,
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
