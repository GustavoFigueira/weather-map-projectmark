import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weather_map/src/core/constants/locale.constants.dart';
import 'package:weather_map/src/domain/enums/temperature_units.enum.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
import 'package:weather_map/src/presentation/home/home.viewmodel.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  String _getFormattedLastUpdatedDateTime() {
    final lastUpdated =
        Get.find<HomeViewModel>().lastUpdated.value ?? DateTime.now();
    return 'Last updated: ${DateFormat.yMd(context.locale.languageCode).add_Hm().format(lastUpdated)}';
  }

  @override
  Widget build(BuildContext context) => Drawer(
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
            _getFormattedLastUpdatedDateTime(),
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
            GlobalManager().temperatureUnit.value == TemperatureUnits.celsius
                ? 'Celsius (°C)'
                : 'Fahrenheit (°F)',
            style: const TextStyle(fontSize: 14),
          ),
          value:
              GlobalManager().temperatureUnit.value == TemperatureUnits.celsius,
          onChanged: (value) {
            setState(() {
              Get.find<GlobalManager>().updateTemperatureUnit(
                value ? TemperatureUnits.celsius : TemperatureUnits.fahrenheit,
              );
              Get.find<HomeViewModel>().initializeData();
            });
          },
          secondary: const Icon(Icons.thermostat, color: Colors.red),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text(
            'Fake Data',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            GlobalManager().fakeData.value ? 'Enabled' : 'Disabled',
            style: const TextStyle(fontSize: 14),
          ),
          value: GlobalManager().fakeData.value,
          onChanged: (option) {
            setState(() {
              Get.find<GlobalManager>().updateFakeData(value: option);
            });
          },
          secondary: const Icon(Icons.data_usage, color: Colors.blue),
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Language',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: DropdownButton<Locale>(
            value: Locale(
              Get.find<GlobalManager>().currentLocale ??
                  kDefaultLocale.languageCode,
            ),
            items:
                kSupportedLocales.map((locale) {
                  String languageName;
                  switch (locale.languageCode) {
                    case 'en':
                      languageName = 'English';
                      break;
                    case 'pt':
                      languageName = 'Portuguese';
                      break;
                    case 'es':
                      languageName = 'Spanish';
                      break;
                    default:
                      languageName = 'English';
                  }
                  return DropdownMenuItem(
                    value: locale,
                    child: Text(languageName),
                  );
                }).toList(),
            onChanged: (Locale? value) {
              Get.find<GlobalManager>().updateCurrentLocale(
                value?.languageCode,
              );
              if (value != null) {
                context.setLocale(value);
              }
            },
          ),
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
