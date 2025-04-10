import 'package:flutter/material.dart';

class CitiesCarouselCard extends StatelessWidget {
  const CitiesCarouselCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
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
  );
}
