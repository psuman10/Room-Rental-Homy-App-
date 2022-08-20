import 'package:homy_app/app/core/utils/enum.dart';

class PropertyModel {
  final String uuid;
  final String name;
  final String description;
  final String coverPhotoURL;
  final List<String> featureImages;
  final String location;
  final int price;
  final String ownerName;
  final String ownerPhoneNumber;
  PropertyType? type;
  PropertyModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.coverPhotoURL,
    required this.featureImages,
    required this.location,
    required this.price,
    required this.ownerName,
    required this.ownerPhoneNumber,
    this.type,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      coverPhotoURL: map['coverPhotoURL'] ?? '',
      featureImages: map['featureImages'] == null
          ? []
          : List<String>.from(map['featureImages']),
      location: map['location'] ?? '',
      price: map['price']?.toInt() ?? 0,
      ownerName: map['ownerName'] ?? '',
      type: map["type"],
      ownerPhoneNumber: map['ownerPhoneNumber'] != null
          ? map['ownerPhoneNumber'].toString()
          : "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description,
      'coverPhotoURL': coverPhotoURL,
      'featureImages': featureImages,
      'location': location,
      'price': price,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
    };
  }
}
