import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preference_dto.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferenceKey = "ride_preference";

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    final preferenceJson = jsonEncode(RidePreferenceDto.toJson(preference));

    final prefsList = prefs.getStringList(_preferenceKey) ?? [];
    prefsList.add(preferenceJson);

    await prefs.setStringList(_preferenceKey, prefsList);
  }

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferenceKey) ?? [];

    return prefsList.map((json) => RidePreferenceDto.fromJson(jsonDecode(json))).toList();
  }

  @override
  Future<void> addPastPreferences(RidePreference ridePreference) async {
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferenceKey) ?? [];
    final preferenceJson = jsonEncode(RidePreferenceDto.toJson(ridePreference));

    if (!prefsList.contains(preferenceJson)) {
      prefsList.add(preferenceJson);
      await prefs.setStringList(_preferenceKey, prefsList);
    }
  }
}
