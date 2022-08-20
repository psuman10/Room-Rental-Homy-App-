import 'package:dartz/dartz.dart';
import 'package:homy_app/app/core/errors/failure.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/data/repository/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository = AuthRepository();

  Future<Either<Failure, UserModel>> register({required UserModel user}) async {
    try {
      final _user = await _authRepository.register(user: user);
      return Right(_user);
    } catch (e) {
      return Left(
        ServerFailure(message: e.toString()),
      );
    }
  }

  Future<Either<Failure, UserModel>> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final _user = await _authRepository.loginWithEmail(
          email: email, password: password);
      return Right(_user);
    } catch (e) {
      return Left(
        ServerFailure(message: e.toString()),
      );
    }
  }

  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final _user = await _authRepository.signInWithGoogle();
      return Right(_user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> loginWithFacebook() async {
    try {
      final _user = await _authRepository.loginWithFacebook();
      return Right(_user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> logout() async {
    try {
      final logout = await _authRepository.logout();
      return Right(logout);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> sendPasswordResetEmail(String email) async {
    try {
      final isSend = await _authRepository.sendPasswordResetEmail(email);
      return Right(isSend);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
