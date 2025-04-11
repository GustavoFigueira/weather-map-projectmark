import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/core/constants/theme.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
import 'package:weather_map/src/presentation/global/widgets/menu_drawer.widget.dart';
import 'package:weather_map/src/presentation/home/home.viewmodel.dart';
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
    final controller = getx.Get.find<HomeViewModel>();

    return getx.Obx(
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
                onRefresh: controller.initializeData,
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
                          title: 'today'.tr(),
                          contentPadding: false,
                          child: TemperatureAlongDayCarouselSlider(
                            loading: controller.loadingWeather.value,
                            nextHoursWeather: controller.nextHoursWeather,
                          ),
                        ),
                        const DefaultHomeHorizontalSpacing(),
                        DefaultHomeSection(
                          title: 'next_7_days'.tr(),
                          child: NextDaysWeatherTable(
                            loading: controller.loadingWeather.value,
                            nextDaysWeather: controller.nextDaysWeather,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (GlobalManager().loading.value) ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
