import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/ui/providers/async_value.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference != pref) {
      _currentPreference = pref;
    }
    notifyListeners();
  }

  void addPreference(RidePreference preference) async {
    await repository.addPreference(preference);
    fetchPastPreferences();
    notifyListeners();
  }

  void fetchPastPreferences() async {
    pastPreferences = AsyncValue.loading();

    try {
      List<RidePreference> ridePref = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(ridePref);
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  // void getPastPreferences()  {
  //   pastPreference =  repository.getPastPreferences() as List<RidePreference>;
  //   notifyListeners();
  // }

  // List<RidePreference> get preferencesHistory =>
  //     pastPreferences.reversed.toList();
}
