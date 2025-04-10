import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/controllers/weather_controller.dart';
import 'package:weather_map/src/models/city.dart';
import 'package:weather_map/src/models/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_map/src/views/widgets/cities_horizontal_carousel.widget.dart';
import 'package:weather_map/src/views/widgets/default_home_horizontal_spacing.widget.dart';
import 'package:weather_map/src/views/widgets/default_home_section.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Helper function to determine the color based on temperature.
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
    final WeatherController controller = Get.find();

    return Scaffold(
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
            Scaffold.of(context).openDrawer();
          },
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4A90E2)),
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
                    'teste',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: Text(context.tr('settings')),
            //   onTap: () {
            //     // Handle settings tap
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.info),
            //   title: Text(context.tr('about')),
            //   onTap: () {
            //     // Handle about tap
            //   },
            // ),
          ],
        ),
      ),
      //  Obx(() {
      //   return ListView.builder(
      //     itemCount: controller.cities.length,
      //     itemBuilder: (context, index) {
      //       City city = controller.cities[index];
      //       Weather? weather = controller.weatherData[city.id];
      //       return buildCityCard(city, weather);
      //     },
      //   );
      // }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultHomeHorizontalSpacing(),
              CitiesHorizontalCarousel(),
              DefaultHomeHorizontalSpacing(),

              DefaultHomeSection(title: 'Today', child: Column(children: [
                  
                ],
              )),
              DefaultHomeSection(
                title: 'Next 7 Days',
                child: Column(children: [
                  
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
