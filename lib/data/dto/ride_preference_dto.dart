import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  final Location departure;
  final DateTime departureDate; 
  final Location arrival;
  final int requestedSeats;

  const RidePreferenceDto({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: LocationDto.fromJson(json['departure']), 
      departureDate: DateTime.parse(json['departure_date']),
      arrival: LocationDto.fromJson(json['arrival']), 
      requestedSeats: json['requested_seats'],
    );
  }

  static Map<String, dynamic> toJson(RidePreference preference) {
    return {
      'departure': LocationDto.json(preference.departure), 
      'departure_date': preference.departureDate.toIso8601String(),
      'arrival': LocationDto.json(preference.arrival), 
      'requested_seats': preference.requestedSeats,
    };
  }
}