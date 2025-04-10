import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/presentation/global/state/global_state_manager.dart';
import 'package:weather_map/src/presentation/global/widgets/menu_drawer.widget.dart';
import 'package:weather_map/src/presentation/home/home_controller.dart';
import 'package:weather_map/src/presentation/home/widgets/cities_horizontal_carousel_slider.widget.dart';
import 'package:weather_map/src/presentation/home/widgets/default_home_horizontal_spacing.widget.dart';
import 'package:weather_map/src/presentation/home/widgets/default_home_section.widget.dart';
import 'package:weather_map/src/presentation/home/widgets/next_days_weather_table.widget.dart';
import 'package:weather_map/src/presentation/home/widgets/temperature_along_day_carousel_slider.widget.dart';

const kHomeDefaultSpacing = 35.0;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: const Color(0xFFF7FAFC),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Weather',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF2D3748),
                  fontSize: 28,
                  fontFamily:
                      GoogleFonts.archivo(
                        fontWeight: FontWeight.w800,
                      ).fontFamily,
                ),
              ),
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/logos/projectmark-icon.svg',
                ),
                onPressed: () {
                  controller.scaffoldKey.currentState?.openDrawer();
                },
              ),
              centerTitle: true,
            ),
            drawer: const MenuDrawer(),
            body: SafeArea(
              child: RefreshIndicator(
                color: AppTheme.primaryColor,
                onRefresh: controller.fetchWeatherForCities,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kHomeDefaultSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CitiesHorizontalCarouselSlider(
                          loading: controller.loadingCities.value,
                          cities: controller.cities.toList(),
                          onCitySelected: controller.updateSelectedCity,
                        ),
                        const DefaultHomeHorizontalSpacing(),
                        DefaultHomeSection(
                          title: 'Today',
                          contentPadding: false,
                          child: TemperatureAlongDayCarouselSlider(
                            loading: controller.loadingWeather.value,
                          ),
                        ),
                        const DefaultHomeHorizontalSpacing(),
                        DefaultHomeSection(
                          title: 'Next 7 Days',
                          child: NextDaysWeatherTable(
                            loading: controller.loadingWeather.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (GlobalStateManager().loading.value)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
