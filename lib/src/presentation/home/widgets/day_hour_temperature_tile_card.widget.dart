import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_map/src/core/helpers/measuring_units.helper.dart';
import 'package:weather_map/src/domain/enums/weather_condition.enum.dart';
import 'package:weather_map/src/presentation/global/widgets/weather_condition_icon.widget.dart';
import 'package:weather_map/src/presentation/home/home.view.dart';

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
  Widget build(BuildContext context) => Obx(
    () => Padding(
      padding: EdgeInsets.only(
        left: hasLeftPadding ? kHomeDefaultSpacing : 0,
        right: hasRightPadding ? kHomeDefaultSpacing : 10,
      ),
      child: Container(
        width: 87,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              isCurrentHour
                  ? const Color(0xFFF6AD55).withValues(alpha: 0.25)
                  : const Color(0xFFEDF2F7),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: 2.5, color: Colors.transparent),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isCurrentHour ? 'Now' : time,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _getTextColor(
                  condition,
                  currentTemperature: isCurrentHour,
                ),
              ),
            ),
            const SizedBox(height: 4),
            WeatherConditionIcon(
              condition: condition,
              fill: _getTextColor(condition, currentTemperature: isCurrentHour),
            ),
            const SizedBox(height: 4),
            Text(
              temperature.formatTemperature(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _getTextColor(
                  condition,
                  currentTemperature: isCurrentHour,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Color _getTextColor(
    WeatherCondition condition, {
    bool currentTemperature = false,
  }) {
    if (currentTemperature) {
      return Color(0xFFF6AD55);
    }

    return const Color(0xFFA0AEC0);
  }
}
