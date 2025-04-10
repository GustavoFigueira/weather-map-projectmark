import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/features/home/home_controller.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/features/home/widgets/next_days_weather_table.widget.dart';
import 'package:weather_map/src/models/city.dart';
import 'package:weather_map/src/models/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_map/src/features/home/widgets/cities_horizontal_carousel_slider.widget.dart';
import 'package:weather_map/src/features/home/widgets/default_home_horizontal_spacing.widget.dart';
import 'package:weather_map/src/features/home/widgets/default_home_section.widget.dart';
import 'package:weather_map/src/features/home/widgets/temperature_along_day_carousel_slider.widget.dart';

const kHomeDefaultSpacing = 35.0;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  /// Helper function to determine the color based on temperature.
  Color getTemperatureColor(double temperature) {
    if (temperature <= 5) {
      return Colors.blue;
    } else if (temperature > 5 && temperature <= 25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget buildCityCard(City city, Weather? weather) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city.label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            weather != null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temperature: ${weather.temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 16,
                        color: getTemperatureColor(weather.temperature),
                      ),
                    ),
                    Text(
                      'Humidity: ${weather.humidity}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Pressure: ${weather.pressure}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
                : const Text('Loading weather data...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Weather',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Color(0xFF2D3748),
            fontSize: 28,
            fontFamily:
                GoogleFonts.archivo(fontWeight: FontWeight.w800).fontFamily,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/logos/projectmark-icon.svg'),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logos/projectmark-icon.svg',
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Weather Map',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Last Update: ${DateTime.now().toLocal().toString().split('.')[0]}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.update, color: Colors.blue),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to Update Weather:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.refresh, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Pull down to refresh the page.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.timer, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Weather updates automatically every 10 minutes.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: () async {
            // Call the controller's method to refresh data
            // await controller.refreshWeatherData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kHomeDefaultSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CitiesHorizontalCarouselSlider(),
                  DefaultHomeHorizontalSpacing(),
                  DefaultHomeSection(
                    title: 'Today',
                    contentPadding: false,
                    child: TemperatureAlongDayCarouselSlider(),
                  ),
                  DefaultHomeHorizontalSpacing(),
                  DefaultHomeSection(
                    title: 'Next 7 Days',
                    child: NextDaysWeatherTable(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
