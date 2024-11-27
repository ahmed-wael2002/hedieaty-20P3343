// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAauburGxNelcU66vhCGE9NZC7xRaoSY48',
    appId: '1:874973524763:web:5fc7abacbf052c328e19be',
    messagingSenderId: '874973524763',
    projectId: 'hedieaty-15d58',
    authDomain: 'hedieaty-15d58.firebaseapp.com',
    storageBucket: 'hedieaty-15d58.firebasestorage.app',
    measurementId: 'G-XN094X6YYX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEQeKWJ55_PSu17ti4jeAWHb84o7nN-dU',
    appId: '1:874973524763:android:8985b42d4444cc228e19be',
    messagingSenderId: '874973524763',
    projectId: 'hedieaty-15d58',
    storageBucket: 'hedieaty-15d58.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5VfS9Nza-fGHbfb16kN9qjn3y27o_WSE',
    appId: '1:874973524763:ios:3bfd92ad950045a28e19be',
    messagingSenderId: '874973524763',
    projectId: 'hedieaty-15d58',
    storageBucket: 'hedieaty-15d58.firebasestorage.app',
    iosBundleId: 'com.example.lectureCode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5VfS9Nza-fGHbfb16kN9qjn3y27o_WSE',
    appId: '1:874973524763:ios:3bfd92ad950045a28e19be',
    messagingSenderId: '874973524763',
    projectId: 'hedieaty-15d58',
    storageBucket: 'hedieaty-15d58.firebasestorage.app',
    iosBundleId: 'com.example.lectureCode',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAauburGxNelcU66vhCGE9NZC7xRaoSY48',
    appId: '1:874973524763:web:5cb62e6fd3cf32d08e19be',
    messagingSenderId: '874973524763',
    projectId: 'hedieaty-15d58',
    authDomain: 'hedieaty-15d58.firebaseapp.com',
    storageBucket: 'hedieaty-15d58.firebasestorage.app',
    measurementId: 'G-E3DPNS61QE',
  );
}
