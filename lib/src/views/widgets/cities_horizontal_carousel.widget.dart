import 'package:flutter/material.dart';

class CitiesHorizontalCarousel extends StatelessWidget {
  const CitiesHorizontalCarousel({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 194,
    padding: const EdgeInsets.only(left: 35),
    child: ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud, size: 50, color: Colors.blue),
                SizedBox(height: 10),
                Text('Card 1', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wb_sunny, size: 50, color: Colors.orange),
                SizedBox(height: 10),
                Text('Card 2', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.ac_unit, size: 50, color: Colors.lightBlue),
                SizedBox(height: 10),
                Text('Card 3', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
