import 'package:homy_app/app/data/models/property.dart';

class AllProperty {
  final List<PropertyModel> houses;
  final List<PropertyModel> rooms;
  final List<PropertyModel> flats;
  AllProperty({
    required this.houses,
    required this.rooms,
    required this.flats,
  });
}
