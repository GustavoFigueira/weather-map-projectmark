import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.update, color: Colors.blue),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(
              'Temperature Unit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              isCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)',
              style: const TextStyle(fontSize: 14),
            ),
            value: isCelsius,
            onChanged: (value) {
              setState(() {
                isCelsius = value;
              });
            },
            secondary: const Icon(Icons.thermostat, color: Colors.red),
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
    );
  }
}
