import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_map/src/domain/models/next_days_weather.model.dart';
import 'package:weather_map/src/presentation/global/widgets/weather_condition_icon.widget.dart';

class NextDaysWeatherTable extends StatefulWidget {
  const NextDaysWeatherTable({
    super.key,
    this.loading = false,
    required this.nextDaysWeather,
  });

  final bool loading;
  final List<NextDaysWeatherModel> nextDaysWeather;

  @override
  NextDaysWeatherTableState createState() => NextDaysWeatherTableState();
}

class NextDaysWeatherTableState extends State<NextDaysWeatherTable> {
  final List<double> _opacityValues = List.filled(7, 0.0);

  @override
  void initState() {
    super.initState();
    _animateWeekWeatherTiles();
  }

  /// Animates the week weather tiles with a staggered effect.
  /// Each tile will animate in sequence with a delay based on its index.
  void _animateWeekWeatherTiles() {
    for (var i = 0; i < _opacityValues.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) {
          setState(() {
            _opacityValues[i] = 1.0;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(3),
      },
      children:
          widget.nextDaysWeather.asMap().entries.map((entry) {
            final index = entry.key;
            final weather = entry.value;

            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(_opacityValues[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        DateFormat.EEEE().format(
                          DateTime.now().add(Duration(days: index)),
                        ),
                        style: TextStyle(
                          fontSize: 17,
                          color: const Color(0xFF718096),
                          fontFamily:
                              GoogleFonts.archivo(
                                fontWeight: FontWeight.w500,
                              ).fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(_opacityValues[index]),
                    child: Center(
                      child: WeatherConditionIcon(condition: weather.condition),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(_opacityValues[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xFF718096),
                          ),
                          children: [
                            TextSpan(
                              text: '${weather.minTemperature}°C',
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.archivo(
                                      fontWeight: FontWeight.w500,
                                    ).fontFamily,
                              ),
                            ),
                            const TextSpan(text: ' / '),
                            TextSpan(
                              text: '${weather.maxTemperature}°',
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.archivo(
                                      fontWeight: FontWeight.w700,
                                    ).fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
