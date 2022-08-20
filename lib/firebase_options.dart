// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCtLM-bhy8eo58cIrkYX6ec32DZyK_2t60',
    appId: '1:863929088693:web:4b5a508cf9c470ac841cfc',
    messagingSenderId: '863929088693',
    projectId: 'secondhome-5bd85',
    authDomain: 'secondhome-5bd85.firebaseapp.com',
    storageBucket: 'secondhome-5bd85.appspot.com',
    measurementId: 'G-89C1T7VY29',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcjB2BNcgYxk-eUkaZiOq8dGoDKOuh0Gc',
    appId: '1:863929088693:android:b00f58ca6f66330a841cfc',
    messagingSenderId: '863929088693',
    projectId: 'secondhome-5bd85',
    storageBucket: 'secondhome-5bd85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm3tHlt17HG7zLZzo7oDJqpgnudKVs4AI',
    appId: '1:863929088693:ios:4c1596058a3c8b7c841cfc',
    messagingSenderId: '863929088693',
    projectId: 'secondhome-5bd85',
    storageBucket: 'secondhome-5bd85.appspot.com',
    iosClientId: '863929088693-ophokf5l7s3rais03pblhvccjvnbvg4o.apps.googleusercontent.com',
    iosBundleId: 'com.homy.sudhoj',
  );
}