// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCjW0SDAXHLOaSzFu2N0fNSJoelKJIA6uE',
    appId: '1:60728787350:web:ff4268e67b12e28cb59db7',
    messagingSenderId: '60728787350',
    projectId: 'brown-otp',
    authDomain: 'brown-otp.firebaseapp.com',
    storageBucket: 'brown-otp.appspot.com',
    measurementId: 'G-J7TV3P9HQP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyActDfkeF9SBbSfG4YrqmrRnC6xAdrUCOo',
    appId: '1:60728787350:android:1f8fa7d77b5ddff2b59db7',
    messagingSenderId: '60728787350',
    projectId: 'brown-otp',
    storageBucket: 'brown-otp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2FNCCkKzF5sF9UpeSM6ht9IUQDyeXBOQ',
    appId: '1:60728787350:ios:d7ef29184da6d80ab59db7',
    messagingSenderId: '60728787350',
    projectId: 'brown-otp',
    storageBucket: 'brown-otp.appspot.com',
    iosBundleId: 'com.example.scissors',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2FNCCkKzF5sF9UpeSM6ht9IUQDyeXBOQ',
    appId: '1:60728787350:ios:9b0f0e4f8920dc5bb59db7',
    messagingSenderId: '60728787350',
    projectId: 'brown-otp',
    storageBucket: 'brown-otp.appspot.com',
    iosBundleId: 'com.example.scissors.RunnerTests',
  );
}
