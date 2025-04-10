// File: lib/app/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import '../models/city.dart';
import '../models/weather.dart';

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
      appBar: AppBar(
        title: const Text('Weather Conditions'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.cities.length,
          itemBuilder: (context, index) {
            City city = controller.cities[index];
            Weather? weather = controller.weatherData[city.id];
            return buildCityCard(city, weather);
          },
        );
      }),
    );
  }
}
