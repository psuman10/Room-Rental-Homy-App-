import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:homy_app/app/core/errors/exception.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/data/models/all_property.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:uuid/uuid.dart';

const String userRef = "users";
const String categoryRef = "categories";
const String propertyRef = "properties";
const String wishListRef = "wish-list";
const String paymentsRef = "payments";
const String myBookingsRef = "my-bookings";

class HomyDatabase {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  HomyDatabase._();

  static Future<void> createUser({required UserModel user}) async {
    try {
      final mapData = user.toJsonForRegister();
      mapData['createdAt'] = Timestamp.now();
      mapData['uuid'] = user.uuid;
      await _firestore.collection(userRef).doc(user.uuid).set(mapData);
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<UserModel> getCurrentProfile({required String userId}) async {
    try {
      final doc = await _firestore.collection(userRef).doc(userId).get();
      final UserModel _user = UserModel(
        uuid: doc["uuid"],
        fullName: doc["fullName"],
        email: doc["email"],
        profileURL: doc["profileURL"],
      );
      return _user;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<List<PropertyModel>> getFlatProperties() async {
    try {
      List<PropertyModel> _houses = [];
      final flatDoc = await _firestore
          .collection(categoryRef)
          .doc("flat")
          .collection(propertyRef)
          .get();

      final _docList = flatDoc.docs.map((document) => document.data()).toList();
      _houses = List<PropertyModel>.from(
          _docList.map((map) => PropertyModel.fromMap(map)));
      return _houses;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<List<PropertyModel>> getRoomProperties() async {
    try {
      List<PropertyModel> _rooms = [];
      final roomDoc = await _firestore
          .collection(categoryRef)
          .doc("room")
          .collection(propertyRef)
          .get();

      final _docList = roomDoc.docs.map((document) => document.data()).toList();
      _rooms = List<PropertyModel>.from(
          _docList.map((map) => PropertyModel.fromMap(map)));
      return _rooms;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<List<PropertyModel>> getHouseProperties() async {
    try {
      List<PropertyModel> _houses = [];
      final houseDoc = await _firestore
          .collection(categoryRef)
          .doc("house")
          .collection(propertyRef)
          .get();

      final _docList =
          houseDoc.docs.map((document) => document.data()).toList();
      _houses = List<PropertyModel>.from(
          _docList.map((map) => PropertyModel.fromMap(map)));
      return _houses;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<AllProperty> getHomePageProperties() async {
    try {
      final roomDoc = await _firestore
          .collection(categoryRef)
          .doc("room")
          .collection(propertyRef)
          .limit(5)
          .get();

      final _roomDocList =
          roomDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _rooms = List<PropertyModel>.from(
          _roomDocList.map((map) => PropertyModel.fromMap(map)));

      final flatDoc = await _firestore
          .collection(categoryRef)
          .doc("flat")
          .collection(propertyRef)
          .limit(5)
          .get();

      final _flatDocList =
          flatDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _flats = List<PropertyModel>.from(
          _flatDocList.map((map) => PropertyModel.fromMap(map)));

      final houseDoc = await _firestore
          .collection(categoryRef)
          .doc("house")
          .collection(propertyRef)
          .limit(5)
          .get();

      final _houseDocList =
          houseDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _houses = List<PropertyModel>.from(
          _houseDocList.map((map) => PropertyModel.fromMap(map)));

      return AllProperty(
        houses: _houses,
        rooms: _rooms,
        flats: _flats,
      );
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<List<PropertyModel>> getAllProperties() async {
    try {
      final roomDoc = await _firestore
          .collection(categoryRef)
          .doc("room")
          .collection(propertyRef)
          .get();

      final _roomDocList =
          roomDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _rooms = List<PropertyModel>.from(
        _roomDocList.map((map) {
          map["type"] = PropertyType.room;
          return PropertyModel.fromMap(map);
        }),
      );

      final flatDoc = await _firestore
          .collection(categoryRef)
          .doc("flat")
          .collection(propertyRef)
          .get();

      final _flatDocList =
          flatDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _flats =
          List<PropertyModel>.from(_flatDocList.map((map) {
        map["type"] = PropertyType.flat;
        return PropertyModel.fromMap(map);
      }));

      final houseDoc = await _firestore
          .collection(categoryRef)
          .doc("house")
          .collection(propertyRef)
          .get();

      final _houseDocList =
          houseDoc.docs.map((document) => document.data()).toList();
      List<PropertyModel> _houses = List<PropertyModel>.from(
        _houseDocList.map((map) {
          map["type"] = PropertyType.house;
          return PropertyModel.fromMap(map);
        }),
      );

      final List<PropertyModel> _properties = [
        ..._houses,
        ..._flats,
        ..._rooms
      ];
      return _properties;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  static Future<bool> addToWishList(PropertyModel property) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _firestore
          .collection(userRef)
          .doc(userId)
          .collection(wishListRef)
          .doc(property.uuid)
          .set(property.toMap());
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  static Future<bool> removeWishList(String propertyId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestore
          .collection(userRef)
          .doc(userId)
          .collection(wishListRef)
          .doc(propertyId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  static Future<List<PropertyModel>> getUserWishList() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<PropertyModel> idList = [];
    final docs = await _firestore
        .collection(userRef)
        .doc(userId)
        .collection(wishListRef)
        .get();
    for (var doc in docs.docs) {
      idList.add(PropertyModel.fromMap(doc.data()));
    }
    return idList;
  }

  static Future<bool> savePayments(
      {required PropertyModel property, int amount = 1000}) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestore.collection(paymentsRef).doc(const Uuid().v4()).set({
        "userId": userId,
        "propertyId": property.uuid,
        "amount": amount,
        "paymentAt": DateTime.now()
      });
      await _firestore
          .collection(userRef)
          .doc(userId)
          .collection(myBookingsRef)
          .doc(const Uuid().v4())
          .set(property.toMap());
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<List<PropertyModel>> getMyBookings() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<PropertyModel> bookings = [];
    final docs = await _firestore
        .collection(userRef)
        .doc(userId)
        .collection(myBookingsRef)
        .get();
    for (var doc in docs.docs) {
      bookings.add(PropertyModel.fromMap(doc.data()));
    }
    return bookings;
  }

  static Future<bool> updateProfile(
      File imageFile, String? name, String userId) async {
    try {
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final firebaseStorageRef =
          _firebaseStorage.ref().child("users/$imageName");
      final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      final TaskSnapshot snap = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snap.ref.getDownloadURL();
      await _firestore.collection(userRef).doc(userId).update({
        "profileURL": downloadUrl,
        "fullName": name,
      });
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }
}
