import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository});

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference != pref) {
      _currentPreference = pref;
    }
    notifyListeners();
  }

  void addPreference(RidePreference preference) {
    repository.addPreference(preference);
    notifyListeners();
  }

  void getPastPreferences() {
    pastPreferences = repository.getPastPreferences();
    notifyListeners();
  }

  List<RidePreference> get preferencesHistory =>
      pastPreferences.reversed.toList();
}
