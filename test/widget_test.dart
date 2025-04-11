// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_map/src/core/services/communicator/dio_client.dart';
import 'package:weather_map/src/data/repository/weather_repository.dart';
import 'package:weather_map/src/domain/usecases/weather.usecase.dart';
import 'package:weather_map/src/presentation/global/state/global_manager.dart';
import 'package:weather_map/src/presentation/global/widgets/menu_drawer.widget.dart';
import 'package:weather_map/src/presentation/home/home.viewmodel.dart';

// Mock classes for dependencies
class MockGlobalManager extends Mock implements GlobalManager {}

class MockDioClient extends Mock implements DioClient {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockFetchWeatherUseCase extends Mock implements FetchWeatherUseCase {}

class MockHomeViewModel extends Mock implements HomeViewModel {}

void main() {
  testWidgets('Fake Data toggle updates GlobalManager', (
    WidgetTester tester,
  ) async {
    // Initialize GlobalManager
    final globalManager = Get.find<GlobalManager>();

    Get
      ..put<GlobalManager>(MockGlobalManager())
      ..lazyPut<DioClient>(MockDioClient.new)
      ..lazyPut<WeatherRepository>(MockWeatherRepository.new)
      ..lazyPut<FetchWeatherUseCase>(MockFetchWeatherUseCase.new)
      ..put<HomeViewModel>(MockHomeViewModel());

    // Build the MenuDrawer widget
    await tester.pumpWidget(
      GetMaterialApp(home: Scaffold(drawer: const MenuDrawer())),
    );

    // Open the drawer
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    // Verify initial state of fakeData
    expect(globalManager.fakeData.value, false);

    // Find the Fake Data switch and toggle it
    final fakeDataSwitch = find.text('Fake Data');
    expect(fakeDataSwitch, findsOneWidget);
    await tester.tap(fakeDataSwitch);
    await tester.pumpAndSettle();

    // Verify that fakeData is updated
    expect(globalManager.fakeData.value, true);
  });
}
