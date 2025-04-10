import 'package:hive/hive.dart';

part 'city.model.g.dart';

@HiveType(typeId: 0)
class CityModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String state;

  @HiveField(4)
  final String country;

  @HiveField(5)
  final String countryShort;

  @HiveField(6)
  final String lat;

  @HiveField(7)
  final String long;

  CityModel({
    required this.id,
    required this.label,
    required this.name,
    required this.state,
    required this.country,
    required this.countryShort,
    required this.lat,
    required this.long,
  });
}