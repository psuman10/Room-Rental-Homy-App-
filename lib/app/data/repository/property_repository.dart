import 'package:firebase_core/firebase_core.dart';
import 'package:homy_app/app/core/errors/exception.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/all_property.dart';

class PropertyRepository {
  Future<AllProperty> getLandingPageProperties() async {
    try {
      final AllProperty allProperty =
          await HomyDatabase.getHomePageProperties();
      return allProperty;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }
}
