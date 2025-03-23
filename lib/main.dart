import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/ui/providers/ride_preference_provider.dart';
import 'package:week_3_blabla_project/data/repository/mock/mock_locations_repository.dart';
import 'package:week_3_blabla_project/data/repository/mock/mock_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/data/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  RidesService.initialize(MockRidesRepository());
  LocationsService.initialize(MockLocationsRepository());
  MockRidePreferencesRepository mockRepo = MockRidePreferencesRepository();

  // 2 - Run the UI
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RidesPreferencesProvider(repository: mockRepo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}
