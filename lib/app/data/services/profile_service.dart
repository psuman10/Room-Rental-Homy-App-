import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:homy_app/app/core/errors/failure.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/data/repository/auth_repository.dart';

class ProfileService {
  final AuthRepository _authRepository = AuthRepository();

  Future<Either<Failure, UserModel>> getCurrentUserProfile() async {
    try {
      return Right(await _authRepository.getCurrentUserProfile());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> uploadImage(
      File imageFile, String name, String userId) async {
    try {
      final updated = await HomyDatabase.updateProfile(imageFile, name, userId);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
