import 'package:week_3_blabla_project/model/location/locations.dart';

class LocationDto {

  static Map<String, dynamic> json(Location location) {
    return {
      'name': location.name,
      'country': location.country.name, 
    };
  }

  static Location fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: countryFromString(json['country']), 
    );
  }

  static Country countryFromString(String value) {
    return Country.values.firstWhere((e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid Country : $value'));
  }
}
