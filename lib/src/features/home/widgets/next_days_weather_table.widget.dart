import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/features/global/widgets/weather_condition_icon.widget.dart';
import 'package:weather_map/src/features/home/widgets/cities_carousel_card.widget.dart';

class NextDaysWeatherTable extends StatefulWidget {
  const NextDaysWeatherTable({super.key});

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
    for (int i = 0; i < _opacityValues.length; i++) {
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
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(3),
      },
      children: List.generate(7, (index) {
        final dayOfWeek =
            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index];
        final weatherCondition = WeatherCondition.sunny;
        final minTemp = 15 + index;
        final maxTemp = 25 + index;

        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation(_opacityValues[index]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    dayOfWeek,
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
                  child: WeatherConditionIcon(condition: weatherCondition),
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
                          text: '$minTemp°C',
                          style: TextStyle(
                            fontFamily:
                                GoogleFonts.archivo(
                                  fontWeight: FontWeight.w500,
                                ).fontFamily,
                          ),
                        ),
                        const TextSpan(text: ' / '),
                        TextSpan(
                          text: '$maxTemp°',
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
      }),
    );
  }
}
