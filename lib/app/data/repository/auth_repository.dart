import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homy_app/app/core/errors/exception.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/user.dart';

class AuthRepository {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel> register({required UserModel user}) async {
    try {
      final UserCredential _credential =
          await _fAuth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      user.uuid = _credential.user!.uid;
      user.email = _credential.user!.email;
      await HomyDatabase.createUser(user: user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<UserModel> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final UserCredential _credential = await _fAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final UserModel user = UserModel(
          uuid: _credential.user!.uid, email: _credential.user!.email);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential _userCred =
          await _fAuth.signInWithCredential(credential);

      final UserModel user = UserModel(
        uuid: _userCred.user!.uid,
        fullName: _userCred.user!.displayName,
        profileURL: _userCred.user!.photoURL,
        email: _userCred.user!.email,
      );
      await HomyDatabase.createUser(user: user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e);
    }
  }

  Future<UserModel> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      switch (loginResult.status) {
        case LoginStatus.success:
          final AuthCredential fbAuthCredential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);
          final UserCredential userCredential =
              await _fAuth.signInWithCredential(fbAuthCredential);
          final UserModel user = UserModel(
            uuid: userCredential.user!.uid,
            fullName: userCredential.user!.displayName,
            profileURL: userCredential.user!.photoURL,
            email: userCredential.user!.email,
          );
          await HomyDatabase.createUser(user: user);
          return user;
        case LoginStatus.failed:
          throw ServerException("Facebook login failed");

        case LoginStatus.cancelled:
          throw ServerException("Facebook login cancelled");

        default:
          throw ServerException("Something went wrong");
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<bool> logout() async {
    try {
      await _fAuth.signOut();
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<UserModel> getCurrentUserProfile() async {
    try {
      final _profile =
          await HomyDatabase.getCurrentProfile(userId: _fAuth.currentUser!.uid);
      return _profile;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _fAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message);
    }
  }

//  bool isUserLoggedIn() {
//     _fAuth.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print("User is currently signed out");
//         return false;
//       } else {
//         print("User is logged in");
//       }
//     });
//   }
}
