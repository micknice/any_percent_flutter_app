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
    
    messagingSenderId: '446589843155',
    projectId: 'any-percent-training--tracker',
    authDomain: 'any-percent-training--tracker.firebaseapp.com',
    storageBucket: 'any-percent-training--tracker.appspot.com',
    measurementId: 'G-9SXY9721DH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    
    
    messagingSenderId: '446589843155',
    projectId: 'any-percent-training--tracker',
    storageBucket: 'any-percent-training--tracker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
   
    messagingSenderId: '446589843155',
    projectId: 'any-percent-training--tracker',
    storageBucket: 'any-percent-training--tracker.appspot.com',
    iosClientId: '446589843155-18hhgqi4m3dpoff522sdjl0h5hoddqm1.apps.googleusercontent.com',
    iosBundleId: 'com.example.anyPercentTrainingTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
   
    messagingSenderId: '446589843155',
    projectId: 'any-percent-training--tracker',
    storageBucket: 'any-percent-training--tracker.appspot.com',
    iosClientId: '446589843155-h84vklp3uouq0eaps3bvinurvdop9sm6.apps.googleusercontent.com',
    iosBundleId: 'com.example.anyPercentTrainingTracker.RunnerTests',
  );
}
